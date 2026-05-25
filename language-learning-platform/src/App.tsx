import React, { useState } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { Navbar } from './components/common/Navbar';
import { LoginPage, RegisterPage } from './components/auth/AuthPages';
import { HomePage } from './pages/HomePage';
import { LearningPage, CoursesPage, ProgressPage, CommunityPage, ProfilePage } from './pages/OtherPages';
import { useAuthStore } from './store';

const AppContent: React.FC = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const { isAuthenticated } = useAuthStore();

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar onMenuToggle={() => setIsMenuOpen(!isMenuOpen)} isMenuOpen={isMenuOpen} />
      
      <main className="pt-16">
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/login" element={isAuthenticated ? <Navigate to="/" /> : <LoginPage />} />
          <Route path="/register" element={isAuthenticated ? <Navigate to="/" /> : <RegisterPage />} />
          <Route path="/courses" element={<CoursesPage />} />
          <Route path="/learning" element={isAuthenticated ? <LearningPage /> : <Navigate to="/login" />} />
          <Route path="/progress" element={isAuthenticated ? <ProgressPage /> : <Navigate to="/login" />} />
          <Route path="/community" element={<CommunityPage />} />
          <Route path="/profile" element={isAuthenticated ? <ProfilePage /> : <Navigate to="/login" />} />
        </Routes>
      </main>
      
      <footer className="bg-white border-t border-gray-200 py-8 mt-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            <div>
              <h4 className="font-semibold text-gray-900 mb-4">关于我们</h4>
              <ul className="space-y-2 text-sm text-gray-500">
                <li><a href="#" className="hover:text-gray-700">公司介绍</a></li>
                <li><a href="#" className="hover:text-gray-700">团队成员</a></li>
                <li><a href="#" className="hover:text-gray-700">加入我们</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold text-gray-900 mb-4">学习资源</h4>
              <ul className="space-y-2 text-sm text-gray-500">
                <li><a href="#" className="hover:text-gray-700">课程中心</a></li>
                <li><a href="#" className="hover:text-gray-700">学习社区</a></li>
                <li><a href="#" className="hover:text-gray-700">学习工具</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold text-gray-900 mb-4">帮助支持</h4>
              <ul className="space-y-2 text-sm text-gray-500">
                <li><a href="#" className="hover:text-gray-700">帮助中心</a></li>
                <li><a href="#" className="hover:text-gray-700">常见问题</a></li>
                <li><a href="#" className="hover:text-gray-700">联系客服</a></li>
              </ul>
            </div>
            <div>
              <h4 className="font-semibold text-gray-900 mb-4">法律条款</h4>
              <ul className="space-y-2 text-sm text-gray-500">
                <li><a href="#" className="hover:text-gray-700">用户协议</a></li>
                <li><a href="#" className="hover:text-gray-700">隐私政策</a></li>
                <li><a href="#" className="hover:text-gray-700">Cookie政策</a></li>
              </ul>
            </div>
          </div>
          
          <div className="mt-8 pt-8 border-t border-gray-200 text-center text-sm text-gray-500">
            <p>© 2024 LinguaLearn. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
};

function App() {
  return (
    <Router>
      <AppContent />
    </Router>
  );
}

export default App;
