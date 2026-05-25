import React, { useState } from 'react';
import { 
  BookOpen, 
  MessageSquare, 
  Mic, 
  Headphones, 
  CheckCircle, 
  XCircle, 
  ArrowRight,
  Volume2,
  RotateCcw,
  Star
} from 'lucide-react';
import type { Language, ModuleType } from '../../types';
import { 
  vocabularyData, 
  grammarData, 
  speakingPhrases, 
  listeningExercises,
  languageNames 
} from '../../data';
import { useLearningStore, useAppStore } from '../../store';

interface VocabularyModuleProps {
  language: Language;
  onComplete: (score: number) => void;
}

export const VocabularyModule: React.FC<VocabularyModuleProps> = ({ language, onComplete }) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [showAnswer, setShowAnswer] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  const [isComplete, setIsComplete] = useState(false);

  const langData = vocabularyData[language];
  const words = langData?.beginner || [];
  const currentWord = words[currentIndex];

  const handleNext = () => {
    if (currentIndex < words.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setShowAnswer(false);
    } else {
      setIsComplete(true);
      const score = Math.round((correctCount / words.length) * 100);
      onComplete(score);
    }
  };

  const handleCorrect = () => {
    setCorrectCount(correctCount + 1);
    handleNext();
  };

  if (isComplete) {
    const score = Math.round((correctCount / words.length) * 100);
    return (
      <div className="card text-center py-12">
        <div className="w-20 h-20 mx-auto mb-6 bg-green-100 rounded-full flex items-center justify-center">
          <CheckCircle className="w-10 h-10 text-green-500" />
        </div>
        <h2 className="text-2xl font-bold text-gray-900 mb-2">学习完成！</h2>
        <p className="text-gray-500 mb-4">正确率: {score}%</p>
        <div className="flex items-center justify-center gap-2 text-yellow-500">
          <Star className="w-6 h-6 fill-yellow-500" />
          <span className="text-lg font-bold">+{Math.round(score / 10)} XP</span>
        </div>
      </div>
    );
  }

  if (!currentWord) {
    return <div className="card text-center py-8">暂无词汇数据</div>;
  }

  return (
    <div className="card">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-2">
          <BookOpen className="w-5 h-5 text-primary-500" />
          <span className="font-medium">词汇学习</span>
        </div>
        <span className="text-sm text-gray-500">
          {currentIndex + 1} / {words.length}
        </span>
      </div>

      <div className="mb-4 h-2 bg-gray-200 rounded-full overflow-hidden">
        <div 
          className="h-full bg-primary-500 transition-all duration-300"
          style={{ width: `${((currentIndex + 1) / words.length) * 100}%` }}
        />
      </div>

      <div className="bg-gradient-to-br from-primary-50 to-accent-50 rounded-xl p-8 text-center mb-6">
        <p className="text-4xl font-bold text-gray-900 mb-4">{currentWord.word}</p>
        {currentWord.pronunciation && (
          <p className="text-lg text-gray-500 mb-4">{currentWord.pronunciation}</p>
        )}
        
        {!showAnswer ? (
          <button
            onClick={() => setShowAnswer(true)}
            className="btn-primary"
          >
            显示答案
          </button>
        ) : (
          <div className="space-y-4">
            <p className="text-2xl font-medium text-primary-600">{currentWord.translation}</p>
            {currentWord.examples && currentWord.examples.length > 0 && (
              <div className="text-left bg-white rounded-lg p-4 mt-4">
                <p className="text-sm font-medium text-gray-700 mb-2">例句：</p>
                {currentWord.examples.map((example: string, i: number) => (
                  <p key={i} className="text-sm text-gray-600 mb-1">• {example}</p>
                ))}
              </div>
            )}
          </div>
        )}
      </div>

      {showAnswer && (
        <div className="flex gap-4">
          <button
            onClick={handleNext}
            className="flex-1 btn-secondary flex items-center justify-center gap-2"
          >
            <XCircle className="w-5 h-5 text-red-500" />
            不认识
          </button>
          <button
            onClick={handleCorrect}
            className="flex-1 btn-primary flex items-center justify-center gap-2"
          >
            <CheckCircle className="w-5 h-5" />
            认识
          </button>
        </div>
      )}
    </div>
  );
};

export const GrammarModule: React.FC<VocabularyModuleProps> = ({ language, onComplete }) => {
  const [currentRule, setCurrentRule] = useState(0);
  const [showExercise, setShowExercise] = useState(false);
  const [userAnswer, setUserAnswer] = useState('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);
  const [correctCount, setCorrectCount] = useState(0);
  const [isComplete, setIsComplete] = useState(false);

  const grammar = grammarData[language]?.beginner || [];
  const current = grammar[currentRule];

  const checkAnswer = () => {
    if (!current) return;
    const exercise = current.exercises[0];
    const correct = userAnswer.toLowerCase().trim() === exercise.correctAnswer.toLowerCase().trim();
    setIsCorrect(correct);
    if (correct) {
      setCorrectCount(correctCount + 1);
    }
  };

  const handleNext = () => {
    if (currentRule < grammar.length - 1) {
      setCurrentRule(currentRule + 1);
      setShowExercise(false);
      setUserAnswer('');
      setIsCorrect(null);
    } else {
      setIsComplete(true);
      const score = Math.round((correctCount / grammar.length) * 100);
      onComplete(score);
    }
  };

  if (isComplete) {
    const score = Math.round((correctCount / grammar.length) * 100);
    return (
      <div className="card text-center py-12">
        <div className="w-20 h-20 mx-auto mb-6 bg-green-100 rounded-full flex items-center justify-center">
          <CheckCircle className="w-10 h-10 text-green-500" />
        </div>
        <h2 className="text-2xl font-bold text-gray-900 mb-2">语法练习完成！</h2>
        <p className="text-gray-500 mb-4">正确率: {score}%</p>
        <div className="flex items-center justify-center gap-2 text-yellow-500">
          <Star className="w-6 h-6 fill-yellow-500" />
          <span className="text-lg font-bold">+{Math.round(score / 10)} XP</span>
        </div>
      </div>
    );
  }

  if (!current) {
    return <div className="card text-center py-8">暂无语法数据</div>;
  }

  return (
    <div className="card">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-2">
          <MessageSquare className="w-5 h-5 text-primary-500" />
          <span className="font-medium">语法练习</span>
        </div>
        <span className="text-sm text-gray-500">
          {currentRule + 1} / {grammar.length}
        </span>
      </div>

      {!showExercise ? (
        <div className="space-y-6">
          <div className="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-xl p-6">
            <h3 className="text-xl font-bold text-gray-900 mb-4">{current.title}</h3>
            <p className="text-gray-700 mb-4">{current.explanation}</p>
            <div className="bg-white rounded-lg p-4">
              <p className="text-sm font-medium text-gray-700 mb-2">例句：</p>
              {current.examples.map((example: string, i: number) => (
                <p key={i} className="text-gray-600 mb-1">• {example}</p>
              ))}
            </div>
          </div>
          <button
            onClick={() => setShowExercise(true)}
            className="w-full btn-primary flex items-center justify-center gap-2"
          >
            开始练习
            <ArrowRight className="w-4 h-4" />
          </button>
        </div>
      ) : (
        <div className="space-y-6">
          <div className="bg-gray-50 rounded-xl p-6">
            <p className="text-lg font-medium text-gray-900 mb-4">
              {current.exercises[0].question}
            </p>
            <input
              type="text"
              value={userAnswer}
              onChange={(e) => setUserAnswer(e.target.value)}
              placeholder="输入答案..."
              className="input-field text-lg"
              disabled={isCorrect !== null}
            />
          </div>

          {isCorrect !== null && (
            <div className={`p-4 rounded-lg ${isCorrect ? 'bg-green-50' : 'bg-red-50'}`}>
              <div className="flex items-center gap-2 mb-2">
                {isCorrect ? (
                  <CheckCircle className="w-5 h-5 text-green-500" />
                ) : (
                  <XCircle className="w-5 h-5 text-red-500" />
                )}
                <span className={`font-medium ${isCorrect ? 'text-green-700' : 'text-red-700'}`}>
                  {isCorrect ? '正确！' : '错误'}
                </span>
              </div>
              {!isCorrect && (
                <p className="text-sm text-red-600">
                  正确答案: {current.exercises[0].correctAnswer}
                </p>
              )}
              <p className="text-sm text-gray-600 mt-2">
                {current.exercises[0].explanation}
              </p>
            </div>
          )}

          <div className="flex gap-4">
            {isCorrect === null ? (
              <button
                onClick={checkAnswer}
                disabled={!userAnswer}
                className="w-full btn-primary disabled:opacity-50"
              >
                检查答案
              </button>
            ) : (
              <button
                onClick={handleNext}
                className="w-full btn-primary flex items-center justify-center gap-2"
              >
                继续
                <ArrowRight className="w-4 h-4" />
              </button>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export const SpeakingModule: React.FC<VocabularyModuleProps> = ({ language, onComplete }) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isRecording, setIsRecording] = useState(false);
  const [hasRecorded, setHasRecorded] = useState(false);
  const [isComplete, setIsComplete] = useState(false);

  const phrases = speakingPhrases[language]?.beginner || [];
  const currentPhrase = phrases[currentIndex];

  const handleRecord = () => {
    setIsRecording(true);
    setTimeout(() => {
      setIsRecording(false);
      setHasRecorded(true);
    }, 2000);
  };

  const handleNext = () => {
    if (currentIndex < phrases.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setHasRecorded(false);
    } else {
      setIsComplete(true);
      onComplete(85);
    }
  };

  if (isComplete) {
    return (
      <div className="card text-center py-12">
        <div className="w-20 h-20 mx-auto mb-6 bg-green-100 rounded-full flex items-center justify-center">
          <CheckCircle className="w-10 h-10 text-green-500" />
        </div>
        <h2 className="text-2xl font-bold text-gray-900 mb-2">口语练习完成！</h2>
        <div className="flex items-center justify-center gap-2 text-yellow-500">
          <Star className="w-6 h-6 fill-yellow-500" />
          <span className="text-lg font-bold">+8 XP</span>
        </div>
      </div>
    );
  }

  if (!currentPhrase) {
    return <div className="card text-center py-8">暂无口语数据</div>;
  }

  return (
    <div className="card">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-2">
          <Mic className="w-5 h-5 text-primary-500" />
          <span className="font-medium">口语跟读</span>
        </div>
        <span className="text-sm text-gray-500">
          {currentIndex + 1} / {phrases.length}
        </span>
      </div>

      <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-xl p-8 text-center mb-6">
        <p className="text-3xl font-bold text-gray-900 mb-4">{currentPhrase.phrase}</p>
        <p className="text-xl text-primary-600 mb-2">{currentPhrase.translation}</p>
        <p className="text-gray-500">{currentPhrase.phonetic}</p>
      </div>

      <div className="flex gap-4 mb-6">
        <button className="flex-1 btn-secondary flex items-center justify-center gap-2">
          <Volume2 className="w-5 h-5" />
          播放发音
        </button>
        <button 
          onClick={handleRecord}
          disabled={isRecording}
          className={`flex-1 ${isRecording ? 'bg-red-500' : 'btn-primary'} text-white rounded-lg flex items-center justify-center gap-2`}
        >
          <Mic className={`w-5 h-5 ${isRecording ? 'animate-pulse' : ''}`} />
          {isRecording ? '录音中...' : '开始跟读'}
        </button>
      </div>

      {hasRecorded && (
        <div className="bg-green-50 rounded-lg p-4 mb-6">
          <div className="flex items-center gap-2 text-green-700">
            <CheckCircle className="w-5 h-5" />
            <span className="font-medium">发音评分: 85分</span>
          </div>
        </div>
      )}

      <button
        onClick={handleNext}
        disabled={!hasRecorded}
        className="w-full btn-primary disabled:opacity-50 flex items-center justify-center gap-2"
      >
        继续
        <ArrowRight className="w-4 h-4" />
      </button>
    </div>
  );
};

export const ListeningModule: React.FC<VocabularyModuleProps> = ({ language, onComplete }) => {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState('');
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);
  const [correctCount, setCorrectCount] = useState(0);
  const [isComplete, setIsComplete] = useState(false);

  const exercises = listeningExercises[language]?.beginner || [];
  const current = exercises[0];
  const questions = current?.questions || [];
  const currentQ = questions[currentQuestion];

  const checkAnswer = () => {
    if (!currentQ) return;
    const correct = selectedAnswer === currentQ.correctAnswer;
    setIsCorrect(correct);
    if (correct) {
      setCorrectCount(correctCount + 1);
    }
  };

  const handleNext = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(currentQuestion + 1);
      setSelectedAnswer('');
      setIsCorrect(null);
    } else {
      setIsComplete(true);
      const score = Math.round((correctCount / questions.length) * 100);
      onComplete(score);
    }
  };

  if (isComplete) {
    const score = Math.round((correctCount / questions.length) * 100);
    return (
      <div className="card text-center py-12">
        <div className="w-20 h-20 mx-auto mb-6 bg-green-100 rounded-full flex items-center justify-center">
          <CheckCircle className="w-10 h-10 text-green-500" />
        </div>
        <h2 className="text-2xl font-bold text-gray-900 mb-2">听力练习完成！</h2>
        <p className="text-gray-500 mb-4">正确率: {score}%</p>
        <div className="flex items-center justify-center gap-2 text-yellow-500">
          <Star className="w-6 h-6 fill-yellow-500" />
          <span className="text-lg font-bold">+{Math.round(score / 10)} XP</span>
        </div>
      </div>
    );
  }

  if (!currentQ) {
    return <div className="card text-center py-8">暂无听力数据</div>;
  }

  return (
    <div className="card">
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-2">
          <Headphones className="w-5 h-5 text-primary-500" />
          <span className="font-medium">听力训练</span>
        </div>
        <span className="text-sm text-gray-500">
          {currentQuestion + 1} / {questions.length}
        </span>
      </div>

      <div className="bg-gradient-to-br from-cyan-50 to-blue-50 rounded-xl p-6 mb-6">
        <div className="flex items-center justify-center gap-4 mb-4">
          <button className="p-4 bg-white rounded-full shadow-md hover:shadow-lg transition-shadow">
            <Volume2 className="w-8 h-8 text-primary-500" />
          </button>
          <div className="text-sm text-gray-500">
            点击播放音频
          </div>
        </div>
        <p className="text-center text-gray-600 italic">
          "{current?.transcript}"
        </p>
      </div>

      <div className="mb-6">
        <p className="text-lg font-medium text-gray-900 mb-4">{currentQ.question}</p>
        <div className="grid grid-cols-2 gap-3">
          {currentQ.options.map((option: string, i: number) => (
            <button
              key={i}
              onClick={() => setSelectedAnswer(option)}
              disabled={isCorrect !== null}
              className={`p-4 rounded-lg border-2 text-left transition-all ${
                selectedAnswer === option
                  ? isCorrect === null
                    ? 'border-primary-500 bg-primary-50'
                    : option === currentQ.correctAnswer
                    ? 'border-green-500 bg-green-50'
                    : 'border-red-500 bg-red-50'
                  : isCorrect !== null && option === currentQ.correctAnswer
                  ? 'border-green-500 bg-green-50'
                  : 'border-gray-200 hover:border-gray-300'
              }`}
            >
              {option}
            </button>
          ))}
        </div>
      </div>

      {isCorrect !== null && !isCorrect && (
        <div className="bg-red-50 rounded-lg p-4 mb-6">
          <p className="text-red-700">
            正确答案: {currentQ.correctAnswer}
          </p>
        </div>
      )}

      <div className="flex gap-4">
        {isCorrect === null ? (
          <button
            onClick={checkAnswer}
            disabled={!selectedAnswer}
            className="w-full btn-primary disabled:opacity-50"
          >
            检查答案
          </button>
        ) : (
          <button
            onClick={handleNext}
            className="w-full btn-primary flex items-center justify-center gap-2"
          >
            继续
            <ArrowRight className="w-4 h-4" />
          </button>
        )}
      </div>
    </div>
  );
};

export const LearningModuleSelector: React.FC = () => {
  const { currentLanguage, addXP } = useLearningStore();
  const { addNotification } = useAppStore();
  const [selectedModule, setSelectedModule] = useState<ModuleType | null>(null);

  const modules = [
    { type: 'vocabulary' as ModuleType, icon: BookOpen, label: '词汇记忆', color: 'from-blue-500 to-cyan-500' },
    { type: 'grammar' as ModuleType, icon: MessageSquare, label: '语法练习', color: 'from-purple-500 to-pink-500' },
    { type: 'speaking' as ModuleType, icon: Mic, label: '口语跟读', color: 'from-orange-500 to-red-500' },
    { type: 'listening' as ModuleType, icon: Headphones, label: '听力训练', color: 'from-green-500 to-teal-500' },
  ];

  const handleComplete = (score: number) => {
    const xp = Math.round(score / 10);
    addXP(xp);
    addNotification({
      id: Date.now().toString(),
      type: 'success',
      title: '学习完成',
      message: `获得 ${xp} 经验值`,
      createdAt: new Date(),
    });
    setSelectedModule(null);
  };

  const renderModule = () => {
    switch (selectedModule) {
      case 'vocabulary':
        return <VocabularyModule language={currentLanguage} onComplete={handleComplete} />;
      case 'grammar':
        return <GrammarModule language={currentLanguage} onComplete={handleComplete} />;
      case 'speaking':
        return <SpeakingModule language={currentLanguage} onComplete={handleComplete} />;
      case 'listening':
        return <ListeningModule language={currentLanguage} onComplete={handleComplete} />;
      default:
        return null;
    }
  };

  if (selectedModule) {
    return (
      <div className="space-y-4">
        <button
          onClick={() => setSelectedModule(null)}
          className="btn-secondary flex items-center gap-2"
        >
          <RotateCcw className="w-4 h-4" />
          返回选择
        </button>
        {renderModule()}
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      {modules.map((module) => {
        const Icon = module.icon;
        return (
          <button
            key={module.type}
            onClick={() => setSelectedModule(module.type)}
            className="card hover:shadow-lg transition-all text-left group"
          >
            <div className={`w-12 h-12 rounded-xl bg-gradient-to-br ${module.color} flex items-center justify-center mb-4 group-hover:scale-110 transition-transform`}>
              <Icon className="w-6 h-6 text-white" />
            </div>
            <h3 className="text-lg font-semibold text-gray-900 mb-1">{module.label}</h3>
            <p className="text-sm text-gray-500">
              {languageNames[currentLanguage]} · 互动式学习
            </p>
          </button>
        );
      })}
    </div>
  );
};
