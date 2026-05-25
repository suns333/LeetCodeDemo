import React from 'react';
import { Link } from 'react-router-dom';
import { 
  BookOpen, 
  ArrowRight, 
  Play,
  MessageSquare,
  Mic,
  Headphones,
  Sparkles,
  CheckCircle
} from 'lucide-react';
import { courses, languageNames, languageFlags } from '../data';
import { useAuthStore, useLearningStore } from '../store';

export const HomePage: React.FC = () => {
  const { isAuthenticated } = useAuthStore();
  const { setCourse, setLanguage } = useLearningStore();
  
  const features = [
    { 
      icon: BookOpen, 
      title: '分级课程体系', 
      description: '从初学者到高级，科学分级，循序渐进',
      color: 'from-blue-500 to-cyan-500'
    },
    { 
      icon: MessageSquare, 
      title: '互动式学习', 
      description: '词汇记忆、语法练习、口语跟读、听力训练',
      color: 'from-purple-500 to-pink-500'
    },
    { 
      icon: Sparkles, 
      title: '个性化推荐', 
      description: 'AI智能推荐，定制专属学习路径',
      color: 'from-green-500 to-teal-500'
    },
  ];

  const languages = [
    { code: 'english', name: '英语', flag: '🇺🇸', learners: '50,000+' },
    { code: 'japanese', name: '日语', flag: '🇯🇵', learners: '30,000+' },
    { code: 'korean', name: '韩语', flag: '🇰🇷', learners: '25,000+' },
    { code: 'spanish', name: '西班牙语', flag: '🇪🇸', learners: '15,000+' },
    { code: 'french', name: '法语', flag: '🇫🇷', learners: '12,000+' },
    { code: 'german', name: '德语', flag: '🇩🇪', learners: '10,000+' },
  ];

  const stats = [
    { value: '100万+', label: '学习者' },
    { value: '500+', label: '精品课程' },
    { value: '50+', label: '语种支持' },
    { value: '4.9', label: '用户评分' },
  ];

  const handleStartLearning = (lang: string) => {
    setLanguage(lang as any);
  };

  return (
    <div className="min-h-screen">
      <section className="relative bg-gradient-to-br from-primary-600 via-primary-500 to-accent-500 text-white overflow-hidden">
        <div className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4xIj48Y2lyY2xlIGN4PSIzMCIgY3k9IjMwIiByPSIyIi8+PC9nPjwvZz48L3N2Zz4=')] opacity-30" />
        
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 md:py-32">
          <div className="grid md:grid-cols-2 gap-12 items-center">
            <div>
              <div className="inline-flex items-center gap-2 px-4 py-2 bg-white/10 backdrop-blur-sm rounded-full mb-6">
                <Sparkles className="w-4 h-4" />
                <span className="text-sm font-medium">AI驱动的智能学习平台</span>
              </div>
              
              <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-6 leading-tight">
                开启你的<br />
                <span className="text-yellow-300">多语种学习之旅</span>
              </h1>
              
              <p className="text-lg md:text-xl text-white/80 mb-8 leading-relaxed">
                沉浸式语言学习体验，涵盖英语、日语、韩语等主流语言。
                科学分级体系，互动式学习模块，让语言学习变得高效有趣。
              </p>
              
              <div className="flex flex-col sm:flex-row gap-4">
                {isAuthenticated ? (
                  <Link to="/learning" className="inline-flex items-center justify-center gap-2 px-8 py-4 bg-white text-primary-600 rounded-xl font-semibold hover:bg-gray-100 transition-colors shadow-lg">
                    <Play className="w-5 h-5" />
                    继续学习
                  </Link>
                ) : (
                  <Link to="/register" className="inline-flex items-center justify-center gap-2 px-8 py-4 bg-white text-primary-600 rounded-xl font-semibold hover:bg-gray-100 transition-colors shadow-lg">
                    免费开始
                    <ArrowRight className="w-5 h-5" />
                  </Link>
                )}
                <Link to="/courses" className="inline-flex items-center justify-center gap-2 px-8 py-4 bg-white/10 backdrop-blur-sm text-white rounded-xl font-semibold hover:bg-white/20 transition-colors border border-white/20">
                  浏览课程
                </Link>
              </div>
            </div>
            
            <div className="hidden md:block">
              <div className="relative">
                <div className="absolute -top-8 -left-8 w-72 h-72 bg-yellow-300/20 rounded-full blur-3xl" />
                <div className="absolute -bottom-8 -right-8 w-72 h-72 bg-pink-300/20 rounded-full blur-3xl" />
                
                <div className="relative bg-white/10 backdrop-blur-lg rounded-3xl p-8 border border-white/20">
                  <div className="grid grid-cols-2 gap-4">
                    {languages.slice(0, 4).map((lang) => (
                      <div key={lang.code} className="bg-white/10 rounded-xl p-4 text-center hover:bg-white/20 transition-colors cursor-pointer">
                        <div className="text-4xl mb-2">{lang.flag}</div>
                        <p className="font-medium">{lang.name}</p>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="py-16 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            {stats.map((stat, i) => (
              <div key={i} className="text-center">
                <p className="text-3xl md:text-4xl font-bold text-gradient mb-2">{stat.value}</p>
                <p className="text-gray-500">{stat.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              为什么选择 LinguaLearn
            </h2>
            <p className="text-lg text-gray-500 max-w-2xl mx-auto">
              我们提供全方位的语言学习解决方案，让学习更高效、更有趣
            </p>
          </div>
          
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            {features.map((feature, i) => {
              const Icon = feature.icon;
              return (
                <div key={i} className="card hover:shadow-lg transition-all group">
                  <div className={`w-14 h-14 rounded-xl bg-gradient-to-br ${feature.color} flex items-center justify-center mb-6 group-hover:scale-110 transition-transform`}>
                    <Icon className="w-7 h-7 text-white" />
                  </div>
                  <h3 className="text-xl font-semibold text-gray-900 mb-3">{feature.title}</h3>
                  <p className="text-gray-500">{feature.description}</p>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      <section className="py-20 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              支持多种语言学习
            </h2>
            <p className="text-lg text-gray-500 max-w-2xl mx-auto">
              涵盖全球主流语言，满足不同学习需求
            </p>
          </div>
          
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6">
            {languages.map((lang) => (
              <Link
                key={lang.code}
                to="/courses"
                onClick={() => handleStartLearning(lang.code)}
                className="card hover:shadow-lg transition-all text-center group"
              >
                <div className="text-5xl mb-4 group-hover:scale-110 transition-transform">
                  {lang.flag}
                </div>
                <h3 className="font-semibold text-gray-900 mb-1">{lang.name}</h3>
                <p className="text-sm text-gray-500">{lang.learners} 学习者</p>
              </Link>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-gradient-to-br from-gray-900 to-gray-800 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid md:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-3xl md:text-4xl font-bold mb-6">
                互动式学习模块
              </h2>
              <p className="text-lg text-gray-300 mb-8">
                四大核心学习模块，全面提升语言能力
              </p>
              
              <div className="space-y-4">
                {[
                  { icon: BookOpen, title: '词汇记忆', desc: '科学记忆曲线，高效掌握词汇' },
                  { icon: MessageSquare, title: '语法练习', desc: '系统语法讲解，实战练习巩固' },
                  { icon: Mic, title: '口语跟读', desc: 'AI语音评测，纠正发音' },
                  { icon: Headphones, title: '听力训练', desc: '真实场景对话，提升听力' },
                ].map((item, i) => {
                  const Icon = item.icon;
                  return (
                    <div key={i} className="flex items-center gap-4 p-4 bg-white/5 rounded-xl hover:bg-white/10 transition-colors">
                      <div className="w-12 h-12 bg-gradient-to-br from-primary-500 to-accent-500 rounded-lg flex items-center justify-center">
                        <Icon className="w-6 h-6 text-white" />
                      </div>
                      <div>
                        <h4 className="font-semibold">{item.title}</h4>
                        <p className="text-sm text-gray-400">{item.desc}</p>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
            
            <div className="relative">
              <div className="bg-gradient-to-br from-primary-500/20 to-accent-500/20 rounded-3xl p-8">
                <div className="bg-white/10 backdrop-blur-lg rounded-2xl p-6 space-y-4">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-green-500 rounded-full flex items-center justify-center">
                      <CheckCircle className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <p className="font-medium">完成词汇学习</p>
                      <p className="text-sm text-gray-400">+10 XP</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center">
                      <CheckCircle className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <p className="font-medium">语法练习100%正确</p>
                      <p className="text-sm text-gray-400">+15 XP</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-orange-500 rounded-full flex items-center justify-center">
                      <CheckCircle className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <p className="font-medium">口语跟读85分</p>
                      <p className="text-sm text-gray-400">+8 XP</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="py-20 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              热门课程推荐
            </h2>
            <p className="text-lg text-gray-500 max-w-2xl mx-auto">
              精选优质课程，开启高效学习
            </p>
          </div>
          
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            {courses.slice(0, 3).map((course) => (
              <div key={course.id} className="card hover:shadow-lg transition-all group overflow-hidden">
                <div className="relative mb-4 rounded-lg overflow-hidden">
                  <img 
                    src={course.thumbnail} 
                    alt={course.title}
                    className="w-full h-48 object-cover group-hover:scale-105 transition-transform duration-300"
                  />
                  <div className="absolute top-3 left-3 flex gap-2">
                    <span className="px-2 py-1 bg-white/90 backdrop-blur-sm rounded-lg text-sm font-medium">
                      {languageFlags[course.language]} {languageNames[course.language]}
                    </span>
                  </div>
                </div>
                
                <h3 className="text-lg font-semibold text-gray-900 mb-2 group-hover:text-primary-600 transition-colors">
                  {course.title}
                </h3>
                <p className="text-gray-500 text-sm mb-4 line-clamp-2">
                  {course.description}
                </p>
                
                <div className="flex items-center justify-between text-sm text-gray-500 mb-4">
                  <span>{course.totalLessons} 课时</span>
                  <span>{course.enrolledCount.toLocaleString()} 人学习</span>
                </div>
                
                <Link 
                  to="/courses"
                  className="w-full btn-primary flex items-center justify-center gap-2"
                  onClick={() => {
                    setCourse(course);
                    setLanguage(course.language);
                  }}
                >
                  开始学习
                  <ArrowRight className="w-4 h-4" />
                </Link>
              </div>
            ))}
          </div>
          
          <div className="text-center mt-12">
            <Link to="/courses" className="btn-secondary inline-flex items-center gap-2">
              查看全部课程
              <ArrowRight className="w-4 h-4" />
            </Link>
          </div>
        </div>
      </section>

      {!isAuthenticated && (
        <section className="py-20 bg-gradient-to-br from-primary-600 to-accent-600 text-white">
          <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
            <h2 className="text-3xl md:text-4xl font-bold mb-6">
              准备好开始学习了吗？
            </h2>
            <p className="text-lg text-white/80 mb-8">
              加入百万学习者，开启你的语言学习之旅
            </p>
            <Link 
              to="/register" 
              className="inline-flex items-center gap-2 px-8 py-4 bg-white text-primary-600 rounded-xl font-semibold hover:bg-gray-100 transition-colors shadow-lg"
            >
              免费注册
              <ArrowRight className="w-5 h-5" />
            </Link>
          </div>
        </section>
      )}
    </div>
  );
};
