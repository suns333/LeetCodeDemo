import React from 'react';
import { Clock, Users, Star } from 'lucide-react';
import { courses, languageNames, languageFlags, levelNames } from '../data';
import { useLearningStore, useAuthStore } from '../store';
import { LearningModuleSelector } from '../components/learning/LearningModules';
import { CourseList } from '../components/courses/CourseList';
import { ProgressDashboard } from '../components/progress/ProgressDashboard';
import { CommunityFeed, Leaderboard } from '../components/community/CommunityFeed';

const dailyTip: Record<string, string> = {
  english: "Practice makes perfect! 每天坚持练习，你的英语一定会越来越好！",
  japanese: "継続は力なり。每天学习一点点，日语进步看得见！",
  korean: "시작이 반이다。开始就是成功的一半，加油！",
};

export const LearningPage: React.FC = () => {
  const { currentLanguage, currentLevel, totalXP, streak, setLanguage, setLevel } = useLearningStore();

  const languages = ['english', 'japanese', 'korean'] as const;
  const levels = ['beginner', 'elementary', 'intermediate', 'upper-intermediate', 'advanced'] as const;

  return (
    <div className="space-y-8">
      <div className="bg-gradient-to-br from-primary-600 to-accent-600 rounded-2xl p-8 text-white">
        <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
          <div>
            <h1 className="text-2xl md:text-3xl font-bold mb-2">
              {languageFlags[currentLanguage]} {languageNames[currentLanguage]} 学习
            </h1>
            <p className="text-white/80">
              当前等级: {levelNames[currentLevel]}
            </p>
          </div>
          
          <div className="flex gap-6">
            <div className="text-center">
              <p className="text-3xl font-bold">{totalXP}</p>
              <p className="text-sm text-white/80">总经验</p>
            </div>
            <div className="text-center">
              <p className="text-3xl font-bold">{streak}</p>
              <p className="text-sm text-white/80">连续天数</p>
            </div>
          </div>
        </div>
        
        <div className="mt-6 p-4 bg-white/10 rounded-xl">
          <p className="text-sm">
            <strong>💡 今日提示：</strong> {dailyTip[currentLanguage] || dailyTip.english}
          </p>
        </div>
      </div>

      <div className="grid md:grid-cols-2 gap-6">
        <div className="card">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">选择学习语言</h3>
          <div className="grid grid-cols-3 gap-3">
            {languages.map((lang) => (
              <button
                key={lang}
                onClick={() => setLanguage(lang)}
                className={`p-4 rounded-xl border-2 text-center transition-all ${
                  currentLanguage === lang
                    ? 'border-primary-500 bg-primary-50'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                <div className="text-3xl mb-2">{languageFlags[lang]}</div>
                <p className="text-sm font-medium">{languageNames[lang]}</p>
              </button>
            ))}
          </div>
        </div>

        <div className="card">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">选择学习等级</h3>
          <div className="space-y-2">
            {levels.map((level, i) => (
              <button
                key={level}
                onClick={() => setLevel(level)}
                className={`w-full p-3 rounded-lg text-left transition-all flex items-center justify-between ${
                  currentLevel === level
                    ? 'bg-primary-50 border-2 border-primary-500'
                    : 'bg-gray-50 hover:bg-gray-100 border-2 border-transparent'
                }`}
              >
                <div className="flex items-center gap-3">
                  <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${
                    i === 0 ? 'bg-green-100 text-green-600' :
                    i === 1 ? 'bg-blue-100 text-blue-600' :
                    i === 2 ? 'bg-yellow-100 text-yellow-600' :
                    i === 3 ? 'bg-orange-100 text-orange-600' :
                    'bg-red-100 text-red-600'
                  }`}>
                    {i + 1}
                  </div>
                  <span className="font-medium">{levelNames[level]}</span>
                </div>
                {currentLevel === level && (
                  <div className="w-2 h-2 rounded-full bg-primary-500" />
                )}
              </button>
            ))}
          </div>
        </div>
      </div>

      <div className="card">
        <h3 className="text-lg font-semibold text-gray-900 mb-6">选择学习模块</h3>
        <LearningModuleSelector />
      </div>

      <div className="card">
        <h3 className="text-lg font-semibold text-gray-900 mb-6">推荐课程</h3>
        <div className="grid md:grid-cols-2 gap-4">
          {courses
            .filter(c => c.language === currentLanguage)
            .slice(0, 2)
            .map(course => (
              <div key={course.id} className="flex gap-4 p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors cursor-pointer">
                <img 
                  src={course.thumbnail} 
                  alt={course.title}
                  className="w-24 h-24 rounded-lg object-cover"
                />
                <div className="flex-1">
                  <h4 className="font-medium text-gray-900 mb-1">{course.title}</h4>
                  <p className="text-sm text-gray-500 mb-2 line-clamp-2">{course.description}</p>
                  <div className="flex items-center gap-4 text-xs text-gray-400">
                    <span className="flex items-center gap-1">
                      <Clock className="w-3 h-3" /> {course.estimatedHours}小时
                    </span>
                    <span className="flex items-center gap-1">
                      <Users className="w-3 h-3" /> {course.enrolledCount.toLocaleString()}
                    </span>
                    <span className="flex items-center gap-1">
                      <Star className="w-3 h-3" /> {course.rating}
                    </span>
                  </div>
                </div>
              </div>
            ))}
        </div>
      </div>
    </div>
  );
};

export const CoursesPage: React.FC = () => {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">课程中心</h1>
          <p className="text-gray-500">浏览所有语言课程，找到适合你的学习内容</p>
        </div>
      </div>
      
      <div className="card">
        <CourseList />
      </div>
    </div>
  );
};

export const ProgressPage: React.FC = () => {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">学习进度</h1>
        <p className="text-gray-500">追踪你的学习进度，查看成长轨迹</p>
      </div>
      
      <ProgressDashboard />
    </div>
  );
};

export const CommunityPage: React.FC = () => {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">学习社区</h1>
        <p className="text-gray-500">与其他学习者交流，分享学习心得</p>
      </div>
      
      <div className="grid lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2">
          <CommunityFeed />
        </div>
        <div>
          <Leaderboard />
        </div>
      </div>
    </div>
  );
};

export const ProfilePage: React.FC = () => {
  const { user, updateProfile } = useAuthStore();
  const { totalXP, streak, progress } = useLearningStore();

  if (!user) return null;

  return (
    <div className="space-y-6">
      <div className="card">
        <div className="flex flex-col md:flex-row gap-6 items-start">
          <img 
            src={user.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user.username}`}
            alt={user.username}
            className="w-24 h-24 rounded-full"
          />
          <div className="flex-1">
            <h1 className="text-2xl font-bold text-gray-900 mb-2">{user.username}</h1>
            <p className="text-gray-500 mb-4">{user.email}</p>
            
            <div className="flex gap-6">
              <div>
                <p className="text-2xl font-bold text-primary-600">{totalXP}</p>
                <p className="text-sm text-gray-500">总经验值</p>
              </div>
              <div>
                <p className="text-2xl font-bold text-orange-500">{streak}</p>
                <p className="text-sm text-gray-500">连续天数</p>
              </div>
              <div>
                <p className="text-2xl font-bold text-green-500">{progress.length}</p>
                <p className="text-sm text-gray-500">完成课程</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="card">
        <h2 className="text-lg font-semibold text-gray-900 mb-6">账号设置</h2>
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">用户名</label>
            <input 
              type="text" 
              value={user.username}
              onChange={(e) => updateProfile({ username: e.target.value })}
              className="input-field"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">邮箱</label>
            <input 
              type="email" 
              value={user.email}
              disabled
              className="input-field bg-gray-50"
            />
          </div>
        </div>
      </div>
    </div>
  );
};
