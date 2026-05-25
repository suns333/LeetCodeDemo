import React from 'react';
import { 
  TrendingUp, 
  Clock, 
  Target, 
  Award, 
  Flame, 
  Calendar,
  BookOpen,
  Star
} from 'lucide-react';
import { useLearningStore } from '../../store';

export const ProgressDashboard: React.FC = () => {
  const { 
    currentLanguage, 
    totalXP, 
    streak, 
    dailyGoal, 
    dailyProgress,
    progress 
  } = useLearningStore();

  const weeklyData = [
    { day: '周一', value: 45, completed: true },
    { day: '周二', value: 60, completed: true },
    { day: '周三', value: 30, completed: true },
    { day: '周四', value: 75, completed: true },
    { day: '周五', value: 50, completed: true },
    { day: '周六', value: 0, completed: false },
    { day: '周日', value: 0, completed: false },
  ];

  const skills = [
    { name: '词汇', progress: 65, color: 'bg-blue-500' },
    { name: '语法', progress: 45, color: 'bg-purple-500' },
    { name: '口语', progress: 30, color: 'bg-orange-500' },
    { name: '听力', progress: 55, color: 'bg-green-500' },
  ];

  const achievements = [
    { icon: '🎯', title: '初学者', description: '完成第一节课', earned: true },
    { icon: '🔥', title: '坚持一周', description: '连续学习7天', earned: streak >= 7 },
    { icon: '📚', title: '学习达人', description: '完成10节课', earned: false },
    { icon: '⭐', title: '完美表现', description: '获得满分', earned: false },
  ];

  return (
    <div className="space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="card">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-yellow-400 to-orange-500 flex items-center justify-center">
              <Star className="w-6 h-6 text-white" />
            </div>
            <div>
              <p className="text-sm text-gray-500">总经验值</p>
              <p className="text-2xl font-bold text-gray-900">{totalXP.toLocaleString()}</p>
            </div>
          </div>
        </div>

        <div className="card">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-orange-400 to-red-500 flex items-center justify-center">
              <Flame className="w-6 h-6 text-white" />
            </div>
            <div>
              <p className="text-sm text-gray-500">连续天数</p>
              <p className="text-2xl font-bold text-gray-900">{streak} 天</p>
            </div>
          </div>
        </div>

        <div className="card">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-blue-400 to-cyan-500 flex items-center justify-center">
              <Clock className="w-6 h-6 text-white" />
            </div>
            <div>
              <p className="text-sm text-gray-500">今日学习</p>
              <p className="text-2xl font-bold text-gray-900">{dailyProgress} 分钟</p>
            </div>
          </div>
        </div>

        <div className="card">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-green-400 to-teal-500 flex items-center justify-center">
              <Target className="w-6 h-6 text-white" />
            </div>
            <div>
              <p className="text-sm text-gray-500">每日目标</p>
              <p className="text-2xl font-bold text-gray-900">{dailyGoal} 分钟</p>
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="card">
          <h3 className="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
            <TrendingUp className="w-5 h-5 text-primary-500" />
            本周学习进度
          </h3>
          
          <div className="space-y-4">
            {weeklyData.map((day, i) => (
              <div key={i} className="flex items-center gap-4">
                <span className="w-12 text-sm text-gray-500">{day.day}</span>
                <div className="flex-1 h-3 bg-gray-100 rounded-full overflow-hidden">
                  <div 
                    className={`h-full ${day.completed ? 'bg-gradient-to-r from-primary-500 to-accent-500' : 'bg-gray-300'} transition-all`}
                    style={{ width: `${Math.min(day.value / dailyGoal * 100, 100)}%` }}
                  />
                </div>
                <span className="w-16 text-sm text-gray-600 text-right">{day.value}分钟</span>
              </div>
            ))}
          </div>
        </div>

        <div className="card">
          <h3 className="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
            <BookOpen className="w-5 h-5 text-primary-500" />
            技能掌握度
          </h3>
          
          <div className="space-y-6">
            {skills.map((skill, i) => (
              <div key={i}>
                <div className="flex items-center justify-between mb-2">
                  <span className="text-sm font-medium text-gray-700">{skill.name}</span>
                  <span className="text-sm text-gray-500">{skill.progress}%</span>
                </div>
                <div className="h-2 bg-gray-100 rounded-full overflow-hidden">
                  <div 
                    className={`h-full ${skill.color} transition-all`}
                    style={{ width: `${skill.progress}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="card">
        <h3 className="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
          <Award className="w-5 h-5 text-primary-500" />
          成就徽章
        </h3>
        
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {achievements.map((achievement, i) => (
            <div 
              key={i}
              className={`p-4 rounded-xl border-2 text-center transition-all ${
                achievement.earned 
                  ? 'border-primary-200 bg-primary-50' 
                  : 'border-gray-200 bg-gray-50 opacity-60'
              }`}
            >
              <div className="text-4xl mb-2">{achievement.icon}</div>
              <p className="font-medium text-gray-900 mb-1">{achievement.title}</p>
              <p className="text-xs text-gray-500">{achievement.description}</p>
              {achievement.earned && (
                <div className="mt-2 inline-flex items-center gap-1 px-2 py-1 bg-primary-100 text-primary-700 rounded-full text-xs">
                  <Star className="w-3 h-3" />
                  已获得
                </div>
              )}
            </div>
          ))}
        </div>
      </div>

      <div className="card">
        <h3 className="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
          <Calendar className="w-5 h-5 text-primary-500" />
          学习日历
        </h3>
        
        <div className="grid grid-cols-7 gap-2">
          {Array.from({ length: 35 }).map((_, i) => {
            const activity = Math.random();
            return (
              <div
                key={i}
                className={`aspect-square rounded-lg ${
                  activity > 0.7 
                    ? 'bg-primary-500' 
                    : activity > 0.4 
                    ? 'bg-primary-300' 
                    : activity > 0.1 
                    ? 'bg-primary-100' 
                    : 'bg-gray-100'
                }`}
                title={`${Math.round(activity * 60)} 分钟`}
              />
            );
          })}
        </div>
        <div className="flex items-center justify-center gap-4 mt-4 text-sm text-gray-500">
          <span className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-gray-100" /> 无活动
          </span>
          <span className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-primary-100" /> 少量
          </span>
          <span className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-primary-300" /> 中等
          </span>
          <span className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-primary-500" /> 大量
          </span>
        </div>
      </div>
    </div>
  );
};
