package com.yatrayatri.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.time.LocalDateTime;
//import java.util.Map;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class WebSocketController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/location")
    @SendTo("/topic/tracking")
    public LocationUpdate handleLocationUpdate(LocationUpdate locationUpdate) {
        // Process location update and broadcast to all subscribers
        locationUpdate.setTimestamp(LocalDateTime.now());
        return locationUpdate;
    }

    @MessageMapping("/trip-status")
    @SendTo("/topic/trip-updates")
    public TripStatusUpdate handleTripStatusUpdate(TripStatusUpdate statusUpdate) {
        // Process trip status update
        statusUpdate.setTimestamp(LocalDateTime.now());
        
        // Notify specific users about their trip updates
        messagingTemplate.convertAndSendToUser(
            statusUpdate.getUserId().toString(), 
            "/queue/notifications", 
            statusUpdate
        );
        
        return statusUpdate;
    }

    // DTO classes for WebSocket messages
    public static class LocationUpdate {
        private Long tripId;
        private Double latitude;
        private Double longitude;
        private LocalDateTime timestamp;
        private String status;

        // Getters and Setters
        public Long getTripId() { return tripId; }
        public void setTripId(Long tripId) { this.tripId = tripId; }
        
        public Double getLatitude() { return latitude; }
        public void setLatitude(Double latitude) { this.latitude = latitude; }
        
        public Double getLongitude() { return longitude; }
        public void setLongitude(Double longitude) { this.longitude = longitude; }
        
        public LocalDateTime getTimestamp() { return timestamp; }
        public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
        
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }

    public static class TripStatusUpdate {
        private Long tripId;
        private Long userId;
        private String status;
        private String message;
        private LocalDateTime timestamp;

        // Getters and Setters
        public Long getTripId() { return tripId; }
        public void setTripId(Long tripId) { this.tripId = tripId; }
        
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }
        
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        
        public LocalDateTime getTimestamp() { return timestamp; }
        public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
    }
}