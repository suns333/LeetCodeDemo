export type Language = 'english' | 'japanese' | 'korean' | 'spanish' | 'french' | 'german';

export type LanguageLevel = 'beginner' | 'elementary' | 'intermediate' | 'upper-intermediate' | 'advanced';

export interface User {
  id: string;
  email: string;
  username: string;
  avatar?: string;
  createdAt: Date;
  learningLanguages: UserLearningLanguage[];
  achievements: Achievement[];
  totalXP: number;
  streak: number;
  lastActiveDate: Date;
}

export interface UserLearningLanguage {
  language: Language;
  level: LanguageLevel;
  progress: number;
  startedAt: Date;
  lastPracticedAt?: Date;
}

export interface Course {
  id: string;
  language: Language;
  level: LanguageLevel;
  title: string;
  description: string;
  thumbnail: string;
  lessons: Lesson[];
  totalLessons: number;
  estimatedHours: number;
  enrolledCount: number;
  rating: number;
}

export interface Lesson {
  id: string;
  courseId: string;
  title: string;
  description: string;
  order: number;
  modules: LearningModule[];
  isLocked: boolean;
  estimatedMinutes: number;
}

export interface LearningModule {
  id: string;
  lessonId: string;
  type: ModuleType;
  title: string;
  content: ModuleContent;
  order: number;
  xpReward: number;
}

export type ModuleType = 'vocabulary' | 'grammar' | 'speaking' | 'listening' | 'reading' | 'writing';

export interface ModuleContent {
  vocabulary?: VocabularyContent;
  grammar?: GrammarContent;
  speaking?: SpeakingContent;
  listening?: ListeningContent;
  reading?: ReadingContent;
  writing?: WritingContent;
}

export interface VocabularyContent {
  words: VocabularyWord[];
  instructions: string;
}

export interface VocabularyWord {
  id: string;
  word: string;
  translation: string;
  pronunciation?: string;
  audioUrl?: string;
  examples: string[];
  imageUrl?: string;
}

export interface GrammarContent {
  rules: GrammarRule[];
  exercises: GrammarExercise[];
  instructions: string;
}

export interface GrammarRule {
  id: string;
  title: string;
  explanation: string;
  examples: string[];
  exceptions?: string[];
}

export interface GrammarExercise {
  id: string;
  type: 'fill-blank' | 'multiple-choice' | 'reorder' | 'correct-error';
  question: string;
  options?: string[];
  correctAnswer: string | string[];
  explanation: string;
}

export interface SpeakingContent {
  phrases: SpeakingPhrase[];
  instructions: string;
}

export interface SpeakingPhrase {
  id: string;
  phrase: string;
  translation: string;
  audioUrl: string;
  phonetic: string;
  difficulty: 'easy' | 'medium' | 'hard';
}

export interface ListeningContent {
  audioUrl: string;
  transcript: string;
  questions: ListeningQuestion[];
  instructions: string;
}

export interface ListeningQuestion {
  id: string;
  question: string;
  options: string[];
  correctAnswer: string;
  timestamp?: number;
}

export interface ReadingContent {
  title: string;
  content: string;
  vocabulary: VocabularyWord[];
  comprehensionQuestions: ComprehensionQuestion[];
  instructions: string;
}

export interface ComprehensionQuestion {
  id: string;
  question: string;
  options: string[];
  correctAnswer: string;
}

export interface WritingContent {
  prompts: WritingPrompt[];
  instructions: string;
}

export interface WritingPrompt {
  id: string;
  prompt: string;
  sampleAnswer: string;
  keywords: string[];
  minLength: number;
}

export interface UserProgress {
  id: string;
  userId: string;
  courseId: string;
  lessonId: string;
  moduleId: string;
  completed: boolean;
  score: number;
  attempts: number;
  completedAt?: Date;
  timeSpent: number;
}

export interface Achievement {
  id: string;
  title: string;
  description: string;
  icon: string;
  category: 'learning' | 'streak' | 'social' | 'special';
  requirement: AchievementRequirement;
  xpReward: number;
  earnedAt?: Date;
}

export interface AchievementRequirement {
  type: 'lessons' | 'xp' | 'streak' | 'perfect_score' | 'community';
  value: number;
}

export interface CommunityPost {
  id: string;
  userId: string;
  user: User;
  language: Language;
  title: string;
  content: string;
  category: 'discussion' | 'question' | 'resource' | 'practice';
  likes: number;
  comments: Comment[];
  createdAt: Date;
  tags: string[];
}

export interface Comment {
  id: string;
  userId: string;
  user: User;
  content: string;
  likes: number;
  createdAt: Date;
}

export interface LearningRecommendation {
  courseId: string;
  course: Course;
  reason: string;
  priority: number;
  matchScore: number;
}
