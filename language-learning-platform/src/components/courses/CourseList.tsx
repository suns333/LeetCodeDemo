import React, { useState } from 'react';
import { Clock, Users, Star, ChevronRight, Filter, Search } from 'lucide-react';
import type { Course, Language, LanguageLevel } from '../../types';
import { courses, languageNames, languageFlags, levelNames, levelColors } from '../../data';
import { useLearningStore } from '../../store';

interface CourseCardProps {
  course: Course;
  onEnroll: (course: Course) => void;
}

const CourseCard: React.FC<CourseCardProps> = ({ course, onEnroll }) => {
  return (
    <div className="card hover:shadow-lg transition-all duration-300 cursor-pointer group">
      <div className="relative mb-4 rounded-lg overflow-hidden">
        <img 
          src={course.thumbnail} 
          alt={course.title}
          className="w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300"
        />
        <div className="absolute top-3 left-3 flex gap-2">
          <span className="px-2 py-1 bg-white/90 backdrop-blur-sm rounded-lg text-sm font-medium flex items-center gap-1">
            {languageFlags[course.language]} {languageNames[course.language]}
          </span>
          <span className={`px-2 py-1 ${levelColors[course.level]} text-white rounded-lg text-sm font-medium`}>
            {levelNames[course.level]}
          </span>
        </div>
      </div>
      
      <h3 className="text-lg font-semibold text-gray-900 mb-2 group-hover:text-primary-600 transition-colors">
        {course.title}
      </h3>
      <p className="text-gray-500 text-sm mb-4 line-clamp-2">
        {course.description}
      </p>
      
      <div className="flex items-center gap-4 text-sm text-gray-500 mb-4">
        <div className="flex items-center gap-1">
          <Clock className="w-4 h-4" />
          <span>{course.estimatedHours}小时</span>
        </div>
        <div className="flex items-center gap-1">
          <Users className="w-4 h-4" />
          <span>{course.enrolledCount.toLocaleString()}人学习</span>
        </div>
        <div className="flex items-center gap-1">
          <Star className="w-4 h-4 text-yellow-500 fill-yellow-500" />
          <span>{course.rating}</span>
        </div>
      </div>
      
      <button 
        onClick={() => onEnroll(course)}
        className="w-full btn-primary flex items-center justify-center gap-2"
      >
        开始学习
        <ChevronRight className="w-4 h-4" />
      </button>
    </div>
  );
};

export const CourseList: React.FC = () => {
  const { setCourse, setLanguage, setLevel } = useLearningStore();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedLanguage, setSelectedLanguage] = useState<Language | 'all'>('all');
  const [selectedLevel, setSelectedLevel] = useState<LanguageLevel | 'all'>('all');
  const [showFilters, setShowFilters] = useState(false);

  const filteredCourses = courses.filter(course => {
    const matchesSearch = course.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         course.description.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesLanguage = selectedLanguage === 'all' || course.language === selectedLanguage;
    const matchesLevel = selectedLevel === 'all' || course.level === selectedLevel;
    return matchesSearch && matchesLanguage && matchesLevel;
  });

  const handleEnroll = (course: Course) => {
    setCourse(course);
    setLanguage(course.language);
    setLevel(course.level);
  };

  const languages: Language[] = ['english', 'japanese', 'korean', 'spanish', 'french', 'german'];
  const levels: LanguageLevel[] = ['beginner', 'elementary', 'intermediate', 'upper-intermediate', 'advanced'];

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row gap-4">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="搜索课程..."
            className="input-field pl-10"
          />
        </div>
        
        <button
          onClick={() => setShowFilters(!showFilters)}
          className="btn-secondary flex items-center gap-2"
        >
          <Filter className="w-4 h-4" />
          筛选
        </button>
      </div>

      {showFilters && (
        <div className="card">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-3">语言</label>
              <div className="flex flex-wrap gap-2">
                <button
                  onClick={() => setSelectedLanguage('all')}
                  className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-all ${
                    selectedLanguage === 'all'
                      ? 'bg-primary-100 text-primary-700'
                      : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                  }`}
                >
                  全部
                </button>
                {languages.map(lang => (
                  <button
                    key={lang}
                    onClick={() => setSelectedLanguage(lang)}
                    className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-all flex items-center gap-1 ${
                      selectedLanguage === lang
                        ? 'bg-primary-100 text-primary-700'
                        : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                    }`}
                  >
                    {languageFlags[lang]} {languageNames[lang]}
                  </button>
                ))}
              </div>
            </div>
            
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-3">等级</label>
              <div className="flex flex-wrap gap-2">
                <button
                  onClick={() => setSelectedLevel('all')}
                  className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-all ${
                    selectedLevel === 'all'
                      ? 'bg-primary-100 text-primary-700'
                      : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                  }`}
                >
                  全部
                </button>
                {levels.map(level => (
                  <button
                    key={level}
                    onClick={() => setSelectedLevel(level)}
                    className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-all ${
                      selectedLevel === level
                        ? `${levelColors[level]} text-white`
                        : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                    }`}
                  >
                    {levelNames[level]}
                  </button>
                ))}
              </div>
            </div>
          </div>
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredCourses.map(course => (
          <CourseCard key={course.id} course={course} onEnroll={handleEnroll} />
        ))}
      </div>

      {filteredCourses.length === 0 && (
        <div className="text-center py-12">
          <p className="text-gray-500">没有找到匹配的课程</p>
        </div>
      )}
    </div>
  );
};

export const CourseDetailPage: React.FC = () => {
  const { currentCourse } = useLearningStore();
  
  if (!currentCourse) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">请选择一个课程</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="relative rounded-2xl overflow-hidden">
        <img 
          src={currentCourse.thumbnail} 
          alt={currentCourse.title}
          className="w-full h-64 object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />
        <div className="absolute bottom-6 left-6 right-6">
          <div className="flex gap-2 mb-3">
            <span className="px-3 py-1 bg-white/90 backdrop-blur-sm rounded-lg text-sm font-medium">
              {languageFlags[currentCourse.language]} {languageNames[currentCourse.language]}
            </span>
            <span className={`px-3 py-1 ${levelColors[currentCourse.level]} text-white rounded-lg text-sm font-medium`}>
              {levelNames[currentCourse.level]}
            </span>
          </div>
          <h1 className="text-3xl font-bold text-white mb-2">{currentCourse.title}</h1>
          <p className="text-white/80">{currentCourse.description}</p>
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="card text-center">
          <Clock className="w-8 h-8 mx-auto text-primary-500 mb-2" />
          <p className="text-2xl font-bold text-gray-900">{currentCourse.estimatedHours}</p>
          <p className="text-sm text-gray-500">预计学时</p>
        </div>
        <div className="card text-center">
          <Users className="w-8 h-8 mx-auto text-primary-500 mb-2" />
          <p className="text-2xl font-bold text-gray-900">{currentCourse.enrolledCount.toLocaleString()}</p>
          <p className="text-sm text-gray-500">学习人数</p>
        </div>
        <div className="card text-center">
          <Star className="w-8 h-8 mx-auto text-yellow-500 fill-yellow-500 mb-2" />
          <p className="text-2xl font-bold text-gray-900">{currentCourse.rating}</p>
          <p className="text-sm text-gray-500">课程评分</p>
        </div>
        <div className="card text-center">
          <div className="w-8 h-8 mx-auto text-primary-500 mb-2 flex items-center justify-center text-2xl font-bold">
            {currentCourse.totalLessons}
          </div>
          <p className="text-2xl font-bold text-gray-900">{currentCourse.totalLessons}</p>
          <p className="text-sm text-gray-500">课时数量</p>
        </div>
      </div>
    </div>
  );
};
