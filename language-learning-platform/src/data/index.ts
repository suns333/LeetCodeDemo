import type { Course, Achievement, Language, LanguageLevel } from '../types';

export const languageNames: Record<Language, string> = {
  english: '英语',
  japanese: '日语',
  korean: '韩语',
  spanish: '西班牙语',
  french: '法语',
  german: '德语',
};

export const languageFlags: Record<Language, string> = {
  english: '🇺🇸',
  japanese: '🇯🇵',
  korean: '🇰🇷',
  spanish: '🇪🇸',
  french: '🇫🇷',
  german: '🇩🇪',
};

export const levelNames: Record<LanguageLevel, string> = {
  beginner: '初学者',
  elementary: '初级',
  intermediate: '中级',
  'upper-intermediate': '中高级',
  advanced: '高级',
};

export const levelColors: Record<LanguageLevel, string> = {
  beginner: 'bg-green-500',
  elementary: 'bg-blue-500',
  intermediate: 'bg-yellow-500',
  'upper-intermediate': 'bg-orange-500',
  advanced: 'bg-red-500',
};

export const courses: Course[] = [
  {
    id: 'en-beg-1',
    language: 'english',
    level: 'beginner',
    title: '英语基础入门',
    description: '从零开始学习英语，掌握基础词汇和语法，建立坚实的语言基础。',
    thumbnail: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=English%20language%20learning%20with%20books%20and%20flags%2C%20modern%20educational%20design&image_size=landscape_4_3',
    lessons: [],
    totalLessons: 20,
    estimatedHours: 40,
    enrolledCount: 12580,
    rating: 4.8,
  },
  {
    id: 'en-int-1',
    language: 'english',
    level: 'intermediate',
    title: '英语中级进阶',
    description: '提升英语综合能力，学习复杂语法结构，扩展词汇量，提高听说读写能力。',
    thumbnail: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Advanced%20English%20conversation%20practice%2C%20professional%20setting&image_size=landscape_4_3',
    lessons: [],
    totalLessons: 30,
    estimatedHours: 60,
    enrolledCount: 8920,
    rating: 4.7,
  },
  {
    id: 'jp-beg-1',
    language: 'japanese',
    level: 'beginner',
    title: '日语入门五十音',
    description: '学习日语五十音图，掌握平假名和片假名，开始日语学习之旅。',
    thumbnail: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Japanese%20hiragana%20and%20katakana%20learning%2C%20traditional%20Japanese%20design&image_size=landscape_4_3',
    lessons: [],
    totalLessons: 15,
    estimatedHours: 30,
    enrolledCount: 9870,
    rating: 4.9,
  },
  {
    id: 'jp-int-1',
    language: 'japanese',
    level: 'intermediate',
    title: '日语N3级备考',
    description: '系统学习日语N3级内容，掌握中级语法和词汇，为JLPT考试做准备。',
    thumbnail: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Japanese%20JLPT%20N3%20exam%20preparation%2C%20study%20materials&image_size=landscape_4_3',
    lessons: [],
    totalLessons: 25,
    estimatedHours: 50,
    enrolledCount: 6540,
    rating: 4.8,
  },
  {
    id: 'kr-beg-1',
    language: 'korean',
    level: 'beginner',
    title: '韩语入门韩文字母',
    description: '学习韩文字母（韩文），掌握发音规则，开始韩语学习。',
    thumbnail: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Korean%20Hangul%20alphabet%20learning%2C%20Korean%20culture%20design&image_size=landscape_4_3',
    lessons: [],
    totalLessons: 18,
    estimatedHours: 35,
    enrolledCount: 7650,
    rating: 4.7,
  },
  {
    id: 'kr-int-1',
    language: 'korean',
    level: 'intermediate',
    title: '韩语TOPIK中级',
    description: '备考TOPIK中级，学习中级语法和词汇，提高韩语综合能力。',
    thumbnail: 'https://trae-api-cn.mchost.guru/api/ide/v1/text_to_image?prompt=Korean%20TOPIK%20exam%20preparation%2C%20modern%20Korean%20design&image_size=landscape_4_3',
    lessons: [],
    totalLessons: 28,
    estimatedHours: 55,
    enrolledCount: 5230,
    rating: 4.6,
  },
];

export const achievements: Achievement[] = [
  {
    id: 'first-lesson',
    title: '初学者',
    description: '完成第一节课',
    icon: '🎯',
    category: 'learning',
    requirement: { type: 'lessons', value: 1 },
    xpReward: 50,
  },
  {
    id: 'ten-lessons',
    title: '学习达人',
    description: '完成10节课',
    icon: '📚',
    category: 'learning',
    requirement: { type: 'lessons', value: 10 },
    xpReward: 200,
  },
  {
    id: 'streak-7',
    title: '坚持一周',
    description: '连续学习7天',
    icon: '🔥',
    category: 'streak',
    requirement: { type: 'streak', value: 7 },
    xpReward: 150,
  },
  {
    id: 'streak-30',
    title: '月度冠军',
    description: '连续学习30天',
    icon: '🏆',
    category: 'streak',
    requirement: { type: 'streak', value: 30 },
    xpReward: 500,
  },
  {
    id: 'perfect-score',
    title: '完美表现',
    description: '获得满分成绩',
    icon: '⭐',
    category: 'learning',
    requirement: { type: 'perfect_score', value: 1 },
    xpReward: 100,
  },
  {
    id: 'xp-1000',
    title: '经验大师',
    description: '累计获得1000经验值',
    icon: '💎',
    category: 'learning',
    requirement: { type: 'xp', value: 1000 },
    xpReward: 300,
  },
  {
    id: 'community-helper',
    title: '社区助手',
    description: '帮助10位学习者',
    icon: '🤝',
    category: 'social',
    requirement: { type: 'community', value: 10 },
    xpReward: 250,
  },
];

export const vocabularyData: Partial<Record<Language, { beginner: Array<{ word: string; translation: string; pronunciation: string; examples: string[] }> }>> = {
  english: {
    beginner: [
      { word: 'hello', translation: '你好', pronunciation: '/həˈloʊ/', examples: ['Hello, how are you?', 'Say hello to your friend.'] },
      { word: 'goodbye', translation: '再见', pronunciation: '/ɡʊdˈbaɪ/', examples: ['Goodbye, see you tomorrow!', 'She said goodbye and left.'] },
      { word: 'thank you', translation: '谢谢', pronunciation: '/θæŋk juː/', examples: ['Thank you for your help.', 'I want to say thank you.'] },
      { word: 'please', translation: '请', pronunciation: '/pliːz/', examples: ['Please sit down.', 'Can you help me, please?'] },
      { word: 'yes', translation: '是', pronunciation: '/jes/', examples: ['Yes, I agree.', 'The answer is yes.'] },
      { word: 'no', translation: '不', pronunciation: '/noʊ/', examples: ['No, thank you.', 'The answer is no.'] },
      { word: 'water', translation: '水', pronunciation: '/ˈwɔːtər/', examples: ['I need some water.', 'Water is essential.'] },
      { word: 'food', translation: '食物', pronunciation: '/fuːd/', examples: ['The food is delicious.', 'I need to buy food.'] },
      { word: 'family', translation: '家庭', pronunciation: '/ˈfæməli/', examples: ['My family is important.', 'I love my family.'] },
      { word: 'friend', translation: '朋友', pronunciation: '/frend/', examples: ['She is my best friend.', 'I met a new friend.'] },
    ],
  },
  japanese: {
    beginner: [
      { word: 'こんにちは', translation: '你好', pronunciation: 'konnichiwa', examples: ['こんにちは、元気ですか？', 'こんにちは、初めまして。'] },
      { word: 'さようなら', translation: '再见', pronunciation: 'sayounara', examples: ['さようなら、また明日！', 'さようなら、お元気で。'] },
      { word: 'ありがとう', translation: '谢谢', pronunciation: 'arigatou', examples: ['ありがとうございます。', 'ありがとう、助かりました。'] },
      { word: 'すみません', translation: '对不起/打扰了', pronunciation: 'sumimasen', examples: ['すみません、道を教えてください。', 'すみません、遅れました。'] },
      { word: 'はい', translation: '是', pronunciation: 'hai', examples: ['はい、そうです。', 'はい、わかりました。'] },
      { word: 'いいえ', translation: '不', pronunciation: 'iie', examples: ['いいえ、違います。', 'いいえ、結構です。'] },
      { word: '水', translation: '水', pronunciation: 'mizu', examples: ['水をください。', '水が欲しいです。'] },
      { word: '食べ物', translation: '食物', pronunciation: 'tabemono', examples: ['食べ物は美味しいです。', '食べ物を買います。'] },
    ],
  },
  korean: {
    beginner: [
      { word: '안녕하세요', translation: '你好', pronunciation: 'annyeonghaseyo', examples: ['안녕하세요, 만나서 반갑습니다.', '안녕하세요, 잘 지내세요?'] },
      { word: '안녕히 가세요', translation: '再见', pronunciation: 'annyeonghi gaseyo', examples: ['안녕히 가세요, 내일 봐요!', '안녕히 가세요, 조심해서 가세요.'] },
      { word: '감사합니다', translation: '谢谢', pronunciation: 'gamsahamnida', examples: ['감사합니다, 도와주셔서.', '감사합니다, 선물 주셔서.'] },
      { word: '미안합니다', translation: '对不起', pronunciation: 'mianhamnida', examples: ['미안합니다, 늦어서.', '미안합니다, 잊어버려서.'] },
      { word: '네', translation: '是', pronunciation: 'ne', examples: ['네, 맞아요.', '네, 알겠습니다.'] },
      { word: '아니요', translation: '不', pronunciation: 'aniyo', examples: ['아니요, 괜찮아요.', '아니요, 안 했어요.'] },
      { word: '물', translation: '水', pronunciation: 'mul', examples: ['물 주세요.', '물이 필요해요.'] },
      { word: '음식', translation: '食物', pronunciation: 'eumsik', examples: ['음식이 맛있어요.', '음식을 사요.'] },
    ],
  },
};

export const grammarData: Partial<Record<Language, { beginner: Array<{ title: string; explanation: string; examples: string[]; exercises: Array<{ type: string; question: string; correctAnswer: string; explanation: string }> }> }>> = {
  english: {
    beginner: [
      {
        title: '简单现在时',
        explanation: '用于描述习惯性动作、普遍真理或固定状态。',
        examples: ['I study English every day.', 'She works in a bank.', 'The sun rises in the east.'],
        exercises: [
          { type: 'fill-blank', question: 'She ___ (go) to school every day.', correctAnswer: 'goes', explanation: '第三人称单数加-s' },
        ],
      },
      {
        title: '简单过去时',
        explanation: '用于描述过去发生的动作或状态。',
        examples: ['I visited Paris last year.', 'She worked here for two years.', 'They played soccer yesterday.'],
        exercises: [
          { type: 'fill-blank', question: 'I ___ (visit) my grandmother yesterday.', correctAnswer: 'visited', explanation: '规则动词加-ed' },
        ],
      },
    ],
  },
  japanese: {
    beginner: [
      {
        title: 'です/ます形（礼貌体）',
        explanation: '用于表示礼貌的说话方式，是日语中最基本的敬语形式。',
        examples: ['私は学生です。', '毎日日本語を勉強します。', 'これは本です。'],
        exercises: [
          { type: 'fill-blank', question: '私は学生___。', correctAnswer: 'です', explanation: '名词句结尾使用です' },
        ],
      },
    ],
  },
  korean: {
    beginner: [
      {
        title: '입니다/습니다（礼貌体）',
        explanation: '韩语的基本礼貌形式，用于正式场合。',
        examples: ['저는 학생입니다.', '매일 한국어를 공부합니다.', '이것은 책입니다.'],
        exercises: [
          { type: 'fill-blank', question: '저는 학생___。', correctAnswer: '입니다', explanation: '名词句结尾使用입니다' },
        ],
      },
    ],
  },
};

export const speakingPhrases: Partial<Record<Language, { beginner: Array<{ phrase: string; translation: string; phonetic: string; difficulty: string }> }>> = {
  english: {
    beginner: [
      { phrase: 'How are you?', translation: '你好吗？', phonetic: 'haʊ ɑːr juː', difficulty: 'easy' },
      { phrase: 'Nice to meet you.', translation: '很高兴认识你。', phonetic: 'naɪs tuː miːt juː', difficulty: 'easy' },
      { phrase: 'What is your name?', translation: '你叫什么名字？', phonetic: 'wʌt ɪz jɔːr neɪm', difficulty: 'easy' },
      { phrase: 'I am from China.', translation: '我来自中国。', phonetic: 'aɪ æm frʌm ˈtʃaɪnə', difficulty: 'easy' },
    ],
  },
  japanese: {
    beginner: [
      { phrase: 'お元気ですか？', translation: '你好吗？', phonetic: 'ogenki desu ka?', difficulty: 'easy' },
      { phrase: '初めまして', translation: '初次见面', phonetic: 'hajimemashite', difficulty: 'easy' },
      { phrase: 'お名前は何ですか？', translation: '你叫什么名字？', phonetic: 'onamae wa nan desu ka?', difficulty: 'easy' },
    ],
  },
  korean: {
    beginner: [
      { phrase: '잘 지내세요?', translation: '你好吗？', phonetic: 'jal jinaeseyo?', difficulty: 'easy' },
      { phrase: '처음 뵙겠습니다', translation: '初次见面', phonetic: 'cheoeum boepgesseumnida', difficulty: 'easy' },
      { phrase: '이름이 뭐예요?', translation: '你叫什么名字？', phonetic: 'ireumi mwoyeyo?', difficulty: 'easy' },
    ],
  },
};

export const listeningExercises: Partial<Record<Language, { beginner: Array<{ title: string; transcript: string; questions: Array<{ question: string; options: string[]; correctAnswer: string }> }> }>> = {
  english: {
    beginner: [
      {
        title: '日常问候',
        transcript: 'Hello, my name is John. I am from America. Nice to meet you.',
        questions: [
          { question: '说话者叫什么名字？', options: ['John', 'Tom', 'Mike', 'David'], correctAnswer: 'John' },
          { question: '说话者来自哪里？', options: ['England', 'America', 'Canada', 'Australia'], correctAnswer: 'America' },
        ],
      },
    ],
  },
  japanese: {
    beginner: [
      {
        title: '自己紹介',
        transcript: 'こんにちは、私は田中です。日本から来ました。よろしくお願いします。',
        questions: [
          { question: '说话者姓什么？', options: ['田中', '山田', '佐藤', '鈴木'], correctAnswer: '田中' },
          { question: '说话者来自哪里？', options: ['日本', '中国', '韓国', '美国'], correctAnswer: '日本' },
        ],
      },
    ],
  },
  korean: {
    beginner: [
      {
        title: '자기소개',
        transcript: '안녕하세요, 저는 김민수입니다. 한국에서 왔습니다. 잘 부탁드립니다.',
        questions: [
          { question: '说话者叫什么？', options: ['김민수', '이영희', '박지성', '최준혁'], correctAnswer: '김민수' },
          { question: '说话者来自哪里？', options: ['한국', '중국', '일본', '미국'], correctAnswer: '한국' },
        ],
      },
    ],
  },
};
