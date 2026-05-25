import { createContext, useContext, useState, useEffect } from 'react';

const AuthContext = createContext(null);

const defaultUser = {
  id: null,
  username: '',
  email: '',
  avatar: '🧑‍🎓',
  nativeLanguage: 'zh',
  learningLanguages: [],
  joinDate: null,
};

export function AuthProvider({ children }) {
  const [user, setUser] = useState(() => {
    const saved = localStorage.getItem('lingoworld_user');
    return saved ? JSON.parse(saved) : defaultUser;
  });
  const [isAuthenticated, setIsAuthenticated] = useState(() => {
    return !!localStorage.getItem('lingoworld_user');
  });

  useEffect(() => {
    if (isAuthenticated && user.id) {
      localStorage.setItem('lingoworld_user', JSON.stringify(user));
    }
  }, [user, isAuthenticated]);

  const login = (email, password) => {
    const users = JSON.parse(localStorage.getItem('lingoworld_users') || '[]');
    const found = users.find((u) => u.email === email && u.password === password);
    if (found) {
      const { password: _, ...userData } = found;
      setUser(userData);
      setIsAuthenticated(true);
      localStorage.setItem('lingoworld_user', JSON.stringify(userData));
      return { success: true };
    }
    return { success: false, error: '邮箱或密码错误' };
  };

  const register = (username, email, password) => {
    const users = JSON.parse(localStorage.getItem('lingoworld_users') || '[]');
    if (users.find((u) => u.email === email)) {
      return { success: false, error: '该邮箱已被注册' };
    }
    const newUser = {
      id: Date.now().toString(),
      username,
      email,
      password,
      avatar: ['🧑‍🎓', '👩‍💻', '👨‍🏫', '👩‍🎨', '🧑‍🔬', '👨‍🚀'][Math.floor(Math.random() * 6)],
      nativeLanguage: 'zh',
      learningLanguages: [],
      joinDate: new Date().toISOString(),
    };
    users.push(newUser);
    localStorage.setItem('lingoworld_users', JSON.stringify(users));
    const { password: _, ...userData } = newUser;
    setUser(userData);
    setIsAuthenticated(true);
    localStorage.setItem('lingoworld_user', JSON.stringify(userData));
    return { success: true };
  };

  const logout = () => {
    setUser(defaultUser);
    setIsAuthenticated(false);
    localStorage.removeItem('lingoworld_user');
  };

  const updateUser = (updates) => {
    setUser((prev) => ({ ...prev, ...updates }));
  };

  return (
    <AuthContext.Provider value={{ user, isAuthenticated, login, register, logout, updateUser }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used within AuthProvider');
  return context;
}
