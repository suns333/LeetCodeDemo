import React, { useState } from 'react';
import { 
  MessageCircle, 
  Heart, 
  Share2, 
  Bookmark,
  Plus,
  Search,
  User,
  Clock,
  Tag
} from 'lucide-react';
import type { Language } from '../../types';
import { languageFlags } from '../../data';

interface Post {
  id: string;
  author: {
    name: string;
    avatar: string;
    level: string;
  };
  language: Language;
  title: string;
  content: string;
  category: 'discussion' | 'question' | 'resource' | 'practice';
  likes: number;
  comments: number;
  createdAt: string;
  tags: string[];
}

const mockPosts: Post[] = [
  {
    id: '1',
    author: { name: '李明', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=liming', level: 'Lv.15' },
    language: 'english',
    title: '分享我的英语学习心得',
    content: '经过三个月的学习，我的英语水平有了很大提升！分享一下我的学习方法：每天坚持背单词，看英文电影，和外国朋友聊天...',
    category: 'discussion',
    likes: 128,
    comments: 24,
    createdAt: '2小时前',
    tags: ['学习方法', '经验分享'],
  },
  {
    id: '2',
    author: { name: '王芳', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=wangfang', level: 'Lv.8' },
    language: 'japanese',
    title: '求助：日语N3语法问题',
    content: '请问「〜てしまう」和「〜ておく」的区别是什么？在什么情况下使用？希望有大神能帮忙解答！',
    category: 'question',
    likes: 45,
    comments: 18,
    createdAt: '5小时前',
    tags: ['语法', 'N3'],
  },
  {
    id: '3',
    author: { name: '张伟', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=zhangwei', level: 'Lv.22' },
    language: 'korean',
    title: '韩语学习资源推荐',
    content: '整理了一些优质的韩语学习资源，包括网站、APP、YouTube频道等，希望对大家有帮助！',
    category: 'resource',
    likes: 256,
    comments: 42,
    createdAt: '1天前',
    tags: ['资源', '网站', 'APP'],
  },
  {
    id: '4',
    author: { name: '陈静', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=chenjing', level: 'Lv.12' },
    language: 'english',
    title: '英语口语练习小组招募',
    content: '组建了一个英语口语练习小组，每周进行线上语音练习，有兴趣的朋友可以加入！',
    category: 'practice',
    likes: 89,
    comments: 31,
    createdAt: '2天前',
    tags: ['口语', '小组学习'],
  },
];

const categoryLabels = {
  discussion: { label: '讨论', color: 'bg-blue-100 text-blue-700' },
  question: { label: '问答', color: 'bg-orange-100 text-orange-700' },
  resource: { label: '资源', color: 'bg-green-100 text-green-700' },
  practice: { label: '练习', color: 'bg-purple-100 text-purple-700' },
};

export const CommunityFeed: React.FC = () => {
  const [posts, setPosts] = useState<Post[]>(mockPosts);
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [selectedLanguage, setSelectedLanguage] = useState<Language | 'all'>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [showNewPost, setShowNewPost] = useState(false);
  const [newPost, setNewPost] = useState({ title: '', content: '', language: 'english' as Language });

  const filteredPosts = posts.filter(post => {
    const matchesCategory = selectedCategory === 'all' || post.category === selectedCategory;
    const matchesLanguage = selectedLanguage === 'all' || post.language === selectedLanguage;
    const matchesSearch = post.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         post.content.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesLanguage && matchesSearch;
  });

  const handleLike = (postId: string) => {
    setPosts(posts.map(post => 
      post.id === postId ? { ...post, likes: post.likes + 1 } : post
    ));
  };

  const handleSubmitPost = () => {
    if (!newPost.title || !newPost.content) return;
    
    const post: Post = {
      id: Date.now().toString(),
      author: { name: '我', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=me', level: 'Lv.1' },
      language: newPost.language,
      title: newPost.title,
      content: newPost.content,
      category: 'discussion',
      likes: 0,
      comments: 0,
      createdAt: '刚刚',
      tags: [],
    };
    
    setPosts([post, ...posts]);
    setShowNewPost(false);
    setNewPost({ title: '', content: '', language: 'english' });
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
        <div className="flex flex-col sm:flex-row gap-4 flex-1">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="搜索帖子..."
              className="input-field pl-10"
            />
          </div>
          
          <select
            value={selectedLanguage}
            onChange={(e) => setSelectedLanguage(e.target.value as Language | 'all')}
            className="input-field w-auto"
          >
            <option value="all">全部语言</option>
            <option value="english">英语</option>
            <option value="japanese">日语</option>
            <option value="korean">韩语</option>
          </select>
        </div>
        
        <button
          onClick={() => setShowNewPost(true)}
          className="btn-primary flex items-center gap-2"
        >
          <Plus className="w-4 h-4" />
          发布帖子
        </button>
      </div>

      <div className="flex gap-2 overflow-x-auto pb-2">
        <button
          onClick={() => setSelectedCategory('all')}
          className={`px-4 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-all ${
            selectedCategory === 'all'
              ? 'bg-primary-100 text-primary-700'
              : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
          }`}
        >
          全部
        </button>
        {Object.entries(categoryLabels).map(([key, value]) => (
          <button
            key={key}
            onClick={() => setSelectedCategory(key)}
            className={`px-4 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-all ${
              selectedCategory === key ? value.color : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
            }`}
          >
            {value.label}
          </button>
        ))}
      </div>

      {showNewPost && (
        <div className="card">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">发布新帖子</h3>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">语言</label>
              <select
                value={newPost.language}
                onChange={(e) => setNewPost({ ...newPost, language: e.target.value as Language })}
                className="input-field"
              >
                <option value="english">英语</option>
                <option value="japanese">日语</option>
                <option value="korean">韩语</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">标题</label>
              <input
                type="text"
                value={newPost.title}
                onChange={(e) => setNewPost({ ...newPost, title: e.target.value })}
                placeholder="输入标题..."
                className="input-field"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">内容</label>
              <textarea
                value={newPost.content}
                onChange={(e) => setNewPost({ ...newPost, content: e.target.value })}
                placeholder="分享你的想法..."
                className="input-field min-h-[120px] resize-none"
              />
            </div>
            <div className="flex gap-3">
              <button
                onClick={handleSubmitPost}
                className="btn-primary"
              >
                发布
              </button>
              <button
                onClick={() => setShowNewPost(false)}
                className="btn-secondary"
              >
                取消
              </button>
            </div>
          </div>
        </div>
      )}

      <div className="space-y-4">
        {filteredPosts.map(post => (
          <div key={post.id} className="card hover:shadow-md transition-shadow">
            <div className="flex items-start gap-4">
              <img
                src={post.author.avatar}
                alt={post.author.name}
                className="w-12 h-12 rounded-full"
              />
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 mb-1">
                  <span className="font-medium text-gray-900">{post.author.name}</span>
                  <span className="text-xs px-2 py-0.5 bg-gray-100 text-gray-600 rounded-full">
                    {post.author.level}
                  </span>
                  <span className="text-sm">
                    {languageFlags[post.language]}
                  </span>
                </div>
                <div className="flex items-center gap-2 text-sm text-gray-500 mb-2">
                  <Clock className="w-4 h-4" />
                  <span>{post.createdAt}</span>
                  <span className={`px-2 py-0.5 rounded-full text-xs ${categoryLabels[post.category].color}`}>
                    {categoryLabels[post.category].label}
                  </span>
                </div>
              </div>
            </div>
            
            <h3 className="text-lg font-semibold text-gray-900 mt-3 mb-2">{post.title}</h3>
            <p className="text-gray-600 mb-4 line-clamp-3">{post.content}</p>
            
            {post.tags.length > 0 && (
              <div className="flex items-center gap-2 mb-4">
                <Tag className="w-4 h-4 text-gray-400" />
                <div className="flex gap-2">
                  {post.tags.map((tag, i) => (
                    <span key={i} className="text-xs px-2 py-1 bg-gray-100 text-gray-600 rounded-lg">
                      {tag}
                    </span>
                  ))}
                </div>
              </div>
            )}
            
            <div className="flex items-center gap-6 pt-4 border-t border-gray-100">
              <button 
                onClick={() => handleLike(post.id)}
                className="flex items-center gap-2 text-gray-500 hover:text-red-500 transition-colors"
              >
                <Heart className="w-5 h-5" />
                <span>{post.likes}</span>
              </button>
              <button className="flex items-center gap-2 text-gray-500 hover:text-primary-500 transition-colors">
                <MessageCircle className="w-5 h-5" />
                <span>{post.comments}</span>
              </button>
              <button className="flex items-center gap-2 text-gray-500 hover:text-primary-500 transition-colors">
                <Share2 className="w-5 h-5" />
                <span>分享</span>
              </button>
              <button className="flex items-center gap-2 text-gray-500 hover:text-yellow-500 transition-colors ml-auto">
                <Bookmark className="w-5 h-5" />
              </button>
            </div>
          </div>
        ))}
      </div>

      {filteredPosts.length === 0 && (
        <div className="text-center py-12">
          <p className="text-gray-500">暂无相关帖子</p>
        </div>
      )}
    </div>
  );
};

export const Leaderboard: React.FC = () => {
  const leaderboard = [
    { rank: 1, name: '张伟', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=zhangwei', xp: 12580, streak: 45, language: 'english' },
    { rank: 2, name: '李明', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=liming', xp: 11250, streak: 38, language: 'japanese' },
    { rank: 3, name: '王芳', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=wangfang', xp: 9870, streak: 32, language: 'korean' },
    { rank: 4, name: '陈静', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=chenjing', xp: 8540, streak: 28, language: 'english' },
    { rank: 5, name: '刘洋', avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=liuyang', xp: 7890, streak: 25, language: 'japanese' },
  ];

  return (
    <div className="card">
      <h3 className="text-lg font-semibold text-gray-900 mb-6 flex items-center gap-2">
        <User className="w-5 h-5 text-primary-500" />
        学习排行榜
      </h3>
      
      <div className="space-y-4">
        {leaderboard.map((user, i) => (
          <div 
            key={i}
            className={`flex items-center gap-4 p-3 rounded-lg ${
              i < 3 ? 'bg-gradient-to-r from-yellow-50 to-orange-50' : 'bg-gray-50'
            }`}
          >
            <div className={`w-8 h-8 rounded-full flex items-center justify-center font-bold ${
              i === 0 ? 'bg-yellow-400 text-white' :
              i === 1 ? 'bg-gray-300 text-white' :
              i === 2 ? 'bg-orange-400 text-white' :
              'bg-gray-200 text-gray-600'
            }`}>
              {user.rank}
            </div>
            <img src={user.avatar} alt={user.name} className="w-10 h-10 rounded-full" />
            <div className="flex-1">
              <p className="font-medium text-gray-900">{user.name}</p>
              <div className="flex items-center gap-2 text-sm text-gray-500">
                <span>{languageFlags[user.language as Language]}</span>
                <span>{user.xp.toLocaleString()} XP</span>
                <span>·</span>
                <span>🔥 {user.streak}天</span>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
