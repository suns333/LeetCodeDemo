import React from 'react';
import { 
  BookOpen, 
  GraduationCap, 
  Trophy, 
  Users, 
  Flame, 
  Star,
  Menu,
  X,
  User,
  LogOut,
  Settings,
  Bell
} from 'lucide-react';
import { Link, useLocation } from 'react-router-dom';
import { useAuthStore } from '../../store';

interface NavbarProps {
  onMenuToggle?: () => void;
  isMenuOpen?: boolean;
}

export const Navbar: React.FC<NavbarProps> = ({ onMenuToggle, isMenuOpen }) => {
  const location = useLocation();
  const { user, isAuthenticated, logout } = useAuthStore();
  
  const navItems = [
    { path: '/', label: '首页', icon: BookOpen },
    { path: '/courses', label: '课程', icon: GraduationCap },
    { path: '/learning', label: '学习', icon: BookOpen },
    { path: '/progress', label: '进度', icon: Trophy },
    { path: '/community', label: '社区', icon: Users },
  ];

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-white border-b border-gray-200 shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <div className="flex items-center gap-8">
            <Link to="/" className="flex items-center gap-2">
              <div className="w-10 h-10 bg-gradient-to-br from-primary-500 to-accent-500 rounded-xl flex items-center justify-center">
                <GraduationCap className="w-6 h-6 text-white" />
              </div>
              <span className="text-xl font-bold text-gradient">LinguaLearn</span>
            </Link>
            
            <div className="hidden md:flex items-center gap-1">
              {navItems.map((item) => {
                const Icon = item.icon;
                const isActive = location.pathname === item.path;
                return (
                  <Link
                    key={item.path}
                    to={item.path}
                    className={`flex items-center gap-2 px-4 py-2 rounded-lg transition-all ${
                      isActive 
                        ? 'bg-primary-50 text-primary-600' 
                        : 'text-gray-600 hover:bg-gray-100'
                    }`}
                  >
                    <Icon className="w-4 h-4" />
                    <span className="text-sm font-medium">{item.label}</span>
                  </Link>
                );
              })}
            </div>
          </div>

          <div className="flex items-center gap-4">
            {isAuthenticated ? (
              <>
                <div className="hidden sm:flex items-center gap-4">
                  <div className="flex items-center gap-2 px-3 py-1.5 bg-orange-50 rounded-lg">
                    <Flame className="w-4 h-4 text-orange-500" />
                    <span className="text-sm font-medium text-orange-600">{user?.streak || 0}</span>
                  </div>
                  <div className="flex items-center gap-2 px-3 py-1.5 bg-yellow-50 rounded-lg">
                    <Star className="w-4 h-4 text-yellow-500" />
                    <span className="text-sm font-medium text-yellow-600">{user?.totalXP || 0} XP</span>
                  </div>
                </div>
                
                <button className="p-2 text-gray-500 hover:bg-gray-100 rounded-lg">
                  <Bell className="w-5 h-5" />
                </button>
                
                <div className="relative group">
                  <button className="flex items-center gap-2 p-1.5 hover:bg-gray-100 rounded-lg">
                    <img 
                      src={user?.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.username}`}
                      alt={user?.username}
                      className="w-8 h-8 rounded-full"
                    />
                  </button>
                  
                  <div className="absolute right-0 top-full mt-2 w-48 bg-white rounded-xl shadow-lg border border-gray-100 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all">
                    <div className="p-3 border-b border-gray-100">
                      <p className="font-medium text-gray-900">{user?.username}</p>
                      <p className="text-sm text-gray-500">{user?.email}</p>
                    </div>
                    <div className="p-2">
                      <Link to="/profile" className="flex items-center gap-2 px-3 py-2 text-gray-600 hover:bg-gray-50 rounded-lg">
                        <User className="w-4 h-4" />
                        <span>个人资料</span>
                      </Link>
                      <Link to="/settings" className="flex items-center gap-2 px-3 py-2 text-gray-600 hover:bg-gray-50 rounded-lg">
                        <Settings className="w-4 h-4" />
                        <span>设置</span>
                      </Link>
                      <button 
                        onClick={logout}
                        className="w-full flex items-center gap-2 px-3 py-2 text-red-600 hover:bg-red-50 rounded-lg"
                      >
                        <LogOut className="w-4 h-4" />
                        <span>退出登录</span>
                      </button>
                    </div>
                  </div>
                </div>
              </>
            ) : (
              <div className="flex items-center gap-3">
                <Link to="/login" className="btn-secondary">
                  登录
                </Link>
                <Link to="/register" className="btn-primary">
                  注册
                </Link>
              </div>
            )}
            
            <button 
              onClick={onMenuToggle}
              className="md:hidden p-2 text-gray-500 hover:bg-gray-100 rounded-lg"
            >
              {isMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
            </button>
          </div>
        </div>
      </div>
      
      {isMenuOpen && (
        <div className="md:hidden border-t border-gray-200 bg-white">
          <div className="px-4 py-3 space-y-1">
            {navItems.map((item) => {
              const Icon = item.icon;
              const isActive = location.pathname === item.path;
              return (
                <Link
                  key={item.path}
                  to={item.path}
                  className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-all ${
                    isActive 
                      ? 'bg-primary-50 text-primary-600' 
                      : 'text-gray-600 hover:bg-gray-100'
                  }`}
                >
                  <Icon className="w-5 h-5" />
                  <span className="font-medium">{item.label}</span>
                </Link>
              );
            })}
          </div>
        </div>
      )}
    </nav>
  );
};
