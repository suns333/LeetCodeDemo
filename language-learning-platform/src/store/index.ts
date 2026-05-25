import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { User, Course, UserProgress, Achievement, Language, LanguageLevel } from '../types';

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  login: (email: string, _password: string) => Promise<boolean>;
  register: (email: string, username: string, _password: string) => Promise<boolean>;
  logout: () => void;
  updateProfile: (updates: Partial<User>) => void;
}

interface LearningState {
  currentCourse: Course | null;
  currentLanguage: Language;
  currentLevel: LanguageLevel;
  progress: UserProgress[];
  totalXP: number;
  streak: number;
  dailyGoal: number;
  dailyProgress: number;
  setCourse: (course: Course) => void;
  setLanguage: (language: Language) => void;
  setLevel: (level: LanguageLevel) => void;
  addProgress: (progress: UserProgress) => void;
  addXP: (amount: number) => void;
  updateStreak: () => void;
  setDailyGoal: (goal: number) => void;
}

interface AppState {
  achievements: Achievement[];
  notifications: Notification[];
  addAchievement: (achievement: Achievement) => void;
  addNotification: (notification: Notification) => void;
  clearNotifications: () => void;
}

interface Notification {
  id: string;
  type: 'success' | 'error' | 'info' | 'achievement';
  title: string;
  message: string;
  createdAt: Date;
}

const generateId = () => Math.random().toString(36).substr(2, 9);

export const useAuthStore = create<AuthState>()(
  persist(
    (set, get) => ({
      user: null,
      isAuthenticated: false,
      isLoading: false,
      
      login: async (email: string, _password: string) => {
        set({ isLoading: true });
        await new Promise(resolve => setTimeout(resolve, 500));
        
        const mockUser: User = {
          id: generateId(),
          email,
          username: email.split('@')[0],
          avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${email}`,
          createdAt: new Date(),
          learningLanguages: [],
          achievements: [],
          totalXP: 0,
          streak: 0,
          lastActiveDate: new Date(),
        };
        
        set({ user: mockUser, isAuthenticated: true, isLoading: false });
        return true;
      },
      
      register: async (email: string, username: string, _password: string) => {
        set({ isLoading: true });
        await new Promise(resolve => setTimeout(resolve, 500));
        
        const mockUser: User = {
          id: generateId(),
          email,
          username,
          avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${username}`,
          createdAt: new Date(),
          learningLanguages: [],
          achievements: [],
          totalXP: 0,
          streak: 0,
          lastActiveDate: new Date(),
        };
        
        set({ user: mockUser, isAuthenticated: true, isLoading: false });
        return true;
      },
      
      logout: () => {
        set({ user: null, isAuthenticated: false });
      },
      
      updateProfile: (updates: Partial<User>) => {
        const { user } = get();
        if (user) {
          set({ user: { ...user, ...updates } });
        }
      },
    }),
    {
      name: 'auth-storage',
    }
  )
);

export const useLearningStore = create<LearningState>()(
  persist(
    (set, get) => ({
      currentCourse: null,
      currentLanguage: 'english',
      currentLevel: 'beginner',
      progress: [],
      totalXP: 0,
      streak: 0,
      dailyGoal: 50,
      dailyProgress: 0,
      
      setCourse: (course: Course) => set({ currentCourse: course }),
      setLanguage: (language: Language) => set({ currentLanguage: language }),
      setLevel: (level: LanguageLevel) => set({ currentLevel: level }),
      
      addProgress: (newProgress: UserProgress) => {
        const { progress } = get();
        const existingIndex = progress.findIndex(
          p => p.moduleId === newProgress.moduleId
        );
        
        if (existingIndex >= 0) {
          const updated = [...progress];
          updated[existingIndex] = newProgress;
          set({ progress: updated });
        } else {
          set({ progress: [...progress, newProgress] });
        }
      },
      
      addXP: (amount: number) => {
        const { totalXP, dailyProgress } = get();
        set({ 
          totalXP: totalXP + amount,
          dailyProgress: dailyProgress + amount 
        });
      },
      
      updateStreak: () => {
        const { streak } = get();
        set({ streak: streak + 1 });
      },
      
      setDailyGoal: (goal: number) => set({ dailyGoal: goal }),
    }),
    {
      name: 'learning-storage',
    }
  )
);

export const useAppStore = create<AppState>()(
  persist(
    (set, _get) => ({
      achievements: [],
      notifications: [],
      
      addAchievement: (achievement: Achievement) => {
        const { achievements } = _get();
        set({ achievements: [...achievements, achievement] });
      },
      
      addNotification: (notification: Notification) => {
        const { notifications } = _get();
        set({ notifications: [...notifications, notification] });
      },
      
      clearNotifications: () => set({ notifications: [] }),
    }),
    {
      name: 'app-storage',
    }
  )
);
