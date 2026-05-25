import { Outlet } from 'react-router-dom';
import Navbar from './Navbar';

export default function Layout() {
  return (
    <div className="app-layout">
      <Navbar />
      <main className="main-content">
        <Outlet />
      </main>
      <footer className="app-footer">
        <div className="footer-inner">
          <div className="footer-brand">
            <span className="footer-logo">🌍 LingoWorld</span>
            <p>让语言学习成为一种享受</p>
          </div>
          <div className="footer-links">
            <div className="footer-col">
              <h4>课程</h4>
              <a href="/courses?lang=en">英语课程</a>
              <a href="/courses?lang=ja">日语课程</a>
              <a href="/courses?lang=ko">韩语课程</a>
            </div>
            <div className="footer-col">
              <h4>社区</h4>
              <a href="/community">学习交流</a>
              <a href="/community">成就系统</a>
            </div>
            <div className="footer-col">
              <h4>关于</h4>
              <a href="#">关于我们</a>
              <a href="#">帮助中心</a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
}
