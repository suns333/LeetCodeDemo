import { createContext, useContext, useState, useEffect } from 'react';
import { useAuth } from './AuthContext';

const LearningContext = createContext(null);

const defaultProgress = {
  enrolledCourses: [],
  completedLessons: {},
  vocabularyMastered: {},
  grammarScores: {},
  dailyStreak: 0,
  lastStudyDate: null,
  totalStudyTime: 0,
  achievements: [],
  weeklyGoal: 5,
  weeklyProgress: 0,
  stats: {
    lessonsCompleted: 0,
    wordsMastered: 0,
    perfectScores: 0,
    languagesLearning: 0,
    coursesCompleted: 0,
    streak: 0,
    postsCount: 0,
    lessonsInOneDay: 0,
  },
};

export function LearningProvider({ children }) {
  const { user, isAuthenticated } = useAuth();
  const [progress, setProgress] = useState(() => {
    if (!isAuthenticated) return defaultProgress;
    const saved = localStorage.getItem(`lingoworld_progress_${user.id}`);
    return saved ? JSON.parse(saved) : defaultProgress;
  });

  useEffect(() => {
    if (isAuthenticated && user.id) {
      localStorage.setItem(`lingoworld_progress_${user.id}`, JSON.stringify(progress));
    }
  }, [progress, isAuthenticated, user.id]);

  const enrollCourse = (courseId) => {
    setProgress((prev) => {
      if (prev.enrolledCourses.includes(courseId)) return prev;
      const newLangCount = new Set([...prev.enrolledCourses, courseId].map((id) => id.split('-')[0])).size;
      return {
        ...prev,
        enrolledCourses: [...prev.enrolledCourses, courseId],
        stats: { ...prev.stats, languagesLearning: newLangCount },
      };
    });
  };

  const completeLesson = (courseId, lessonId) => {
    setProgress((prev) => {
      const courseLessons = prev.completedLessons[courseId] || [];
      if (courseLessons.includes(lessonId)) return prev;
      const today = new Date().toDateString();
      const isConsecutive = prev.lastStudyDate
        ? (new Date(today) - new Date(prev.lastStudyDate)) / (1000 * 60 * 60 * 24) <= 1
        : true;
      const newStreak = isConsecutive ? prev.dailyStreak + 1 : 1;
      const newLessons = { ...prev.completedLessons, [courseId]: [...courseLessons, lessonId] };
      const totalCompleted = Object.values(newLessons).reduce((sum, arr) => sum + arr.length, 0);
      return {
        ...prev,
        completedLessons: newLessons,
        dailyStreak: newStreak,
        lastStudyDate: today,
        weeklyProgress: prev.weeklyProgress + 1,
        stats: {
          ...prev.stats,
          lessonsCompleted: totalCompleted,
          streak: newStreak,
        },
      };
    });
  };

  const masterWord = (lang, wordId) => {
    setProgress((prev) => {
      const langWords = prev.vocabularyMastered[lang] || [];
      if (langWords.includes(wordId)) return prev;
      const newVocab = { ...prev.vocabularyMastered, [lang]: [...langWords, wordId] };
      const totalWords = Object.values(newVocab).reduce((sum, arr) => sum + arr.length, 0);
      return {
        ...prev,
        vocabularyMastered: newVocab,
        stats: { ...prev.stats, wordsMastered: totalWords },
      };
    });
  };

  const addPerfectScore = () => {
    setProgress((prev) => ({
      ...prev,
      stats: { ...prev.stats, perfectScores: prev.stats.perfectScores + 1 },
    }));
  };

  const addStudyTime = (minutes) => {
    setProgress((prev) => ({
      ...prev,
      totalStudyTime: prev.totalStudyTime + minutes,
    }));
  };

  const unlockAchievement = (achievementId) => {
    setProgress((prev) => {
      if (prev.achievements.includes(achievementId)) return prev;
      return { ...prev, achievements: [...prev.achievements, achievementId] };
    });
  };

  const checkAchievements = () => {
    setProgress((prev) => {
      const { stats } = prev;
      const newAchievements = [...prev.achievements];
      const checks = [
        { id: 'first-lesson', cond: stats.lessonsCompleted >= 1 },
        { id: 'week-streak', cond: stats.streak >= 7 },
        { id: 'vocabulary-100', cond: stats.wordsMastered >= 100 },
        { id: 'vocabulary-500', cond: stats.wordsMastered >= 500 },
        { id: 'perfect-score', cond: stats.perfectScores >= 1 },
        { id: 'multi-lang', cond: stats.languagesLearning >= 2 },
        { id: 'month-streak', cond: stats.streak >= 30 },
      ];
      checks.forEach(({ id, cond }) => {
        if (cond && !newAchievements.includes(id)) newAchievements.push(id);
      });
      return { ...prev, achievements: newAchievements };
    });
  };

  return (
    <LearningContext.Provider
      value={{
        progress,
        enrollCourse,
        completeLesson,
        masterWord,
        addPerfectScore,
        addStudyTime,
        unlockAchievement,
        checkAchievements,
      }}
    >
      {children}
    </LearningContext.Provider>
  );
}

export function useLearning() {
  const context = useContext(LearningContext);
  if (!context) throw new Error('useLearning must be used within LearningProvider');
  return context;
}
