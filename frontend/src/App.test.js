import { render, screen } from '@testing-library/react';
import App from './App';

test('renders welcome message', () => {
  render(<App />);
  const welcomeElement = screen.getByText(/Welcome to Yatra Yatri/i);
  expect(welcomeElement).toBeInTheDocument();
});

test('renders features section', () => {
  render(<App />);
  const easyBookingElement = screen.getByText(/Easy Booking/i);
  const realTimeTrackingElement = screen.getByText(/Real-time Tracking/i);
  const securePaymentsElement = screen.getByText(/Secure Payments/i);
  
  expect(easyBookingElement).toBeInTheDocument();
  expect(realTimeTrackingElement).toBeInTheDocument();
  expect(securePaymentsElement).toBeInTheDocument();
});

test('renders app header', () => {
  render(<App />);
  const headerElements = screen.getAllByText(/Yatra Yatri/i);
  expect(headerElements.length).toBeGreaterThan(0);
});