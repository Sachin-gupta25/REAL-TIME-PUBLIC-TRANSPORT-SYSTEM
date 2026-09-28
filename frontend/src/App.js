import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import './App.css';

// Components (we'll create basic versions)
const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  
  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch('/api/auth/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
      });
      
      if (response.ok) {
        const data = await response.json();
        localStorage.setItem('token', data.token);
        window.location.href = '/dashboard';
      } else {
        alert('Login failed');
      }
    } catch (error) {
      console.error('Login error:', error);
    }
  };
  
  return (
    <div className="login-container">
      <h2>Yatra Yatri Login</h2>
      <form onSubmit={handleLogin}>
        <div>
          <input
            type="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
        </div>
        <div>
          <input
            type="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
        </div>
        <button type="submit">Login</button>
      </form>
    </div>
  );
};

const Dashboard = () => {
  const [trips, setTrips] = useState([]);
  
  useEffect(() => {
    fetchTrips();
  }, []);
  
  const fetchTrips = async () => {
    try {
      const response = await fetch('/api/trips/search');
      if (response.ok) {
        const data = await response.json();
        setTrips(data);
      }
    } catch (error) {
      console.error('Error fetching trips:', error);
    }
  };
  
  return (
    <div className="dashboard">
      <h2>Available Trips</h2>
      <div className="trips-grid">
        {trips.map(trip => (
          <div key={trip.id} className="trip-card">
            <h3>{trip.tripName}</h3>
            <p>From: {trip.departureLocation}</p>
            <p>To: {trip.destination}</p>
            <p>Price: ₹{trip.price}</p>
            <p>Available Seats: {trip.availableSeats}</p>
          </div>
        ))}
      </div>
    </div>
  );
};

const Home = () => {
  return (
    <div className="home">
      <h1>Welcome to Yatra Yatri</h1>
      <p>Your complete travel management system</p>
      <div className="features">
        <div className="feature">
          <h3>Easy Booking</h3>
          <p>Book your trips with just a few clicks</p>
        </div>
        <div className="feature">
          <h3>Real-time Tracking</h3>
          <p>Track your journey in real-time</p>
        </div>
        <div className="feature">
          <h3>Secure Payments</h3>
          <p>Safe and secure payment options</p>
        </div>
      </div>
    </div>
  );
};

function App() {
  const [isInstallable, setIsInstallable] = useState(false);
  const [deferredPrompt, setDeferredPrompt] = useState(null);
  
  useEffect(() => {
    // PWA Install prompt
    window.addEventListener('beforeinstallprompt', (e) => {
      e.preventDefault();
      setDeferredPrompt(e);
      setIsInstallable(true);
    });
  }, []);
  
  const handleInstallClick = () => {
    if (deferredPrompt) {
      deferredPrompt.prompt();
      deferredPrompt.userChoice.then((choiceResult) => {
        if (choiceResult.outcome === 'accepted') {
          console.log('User accepted the install prompt');
        }
        setDeferredPrompt(null);
        setIsInstallable(false);
      });
    }
  };
  
  return (
    <Router>
      <div className="App">
        <header className="app-header">
          <h1>Yatra Yatri</h1>
          {isInstallable && (
            <button onClick={handleInstallClick} className="install-button">
              Install App
            </button>
          )}
        </header>
        
        <main>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/login" element={<Login />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="*" element={<Navigate to="/" />} />
          </Routes>
        </main>
      </div>
    </Router>
  );
}

export default App;