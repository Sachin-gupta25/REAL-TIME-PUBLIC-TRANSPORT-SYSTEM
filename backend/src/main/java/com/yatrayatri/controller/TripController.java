package com.yatrayatri.controller;

import com.yatrayatri.entity.Trip;
import com.yatrayatri.repository.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/trips")
@CrossOrigin(origins = "*", maxAge = 3600)
public class TripController {

    @Autowired
    private TripRepository tripRepository;

    @GetMapping("/search")
    public ResponseEntity<List<Trip>> searchTrips(
            @RequestParam(required = false) String destination,
            @RequestParam(required = false) String departure,
            @RequestParam(required = false, defaultValue = "1") Integer minSeats) {
        
        if (destination != null && !destination.isEmpty()) {
            return ResponseEntity.ok(tripRepository.findByDestinationContainingIgnoreCase(destination));
        } else if (departure != null && !departure.isEmpty()) {
            return ResponseEntity.ok(tripRepository.findByDepartureLocationContainingIgnoreCase(departure));
        } else {
            return ResponseEntity.ok(tripRepository.findAvailableTrips(minSeats));
        }
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasRole('USER') or hasRole('ADMIN')")
    public ResponseEntity<Trip> getTripById(@PathVariable Long id) {
        Optional<Trip> trip = tripRepository.findById(id);
        return trip.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<List<Trip>> getAllTrips() {
        return ResponseEntity.ok(tripRepository.findAll());
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Trip> createTrip(@RequestBody Trip trip) {
        Trip savedTrip = tripRepository.save(trip);
        return ResponseEntity.ok(savedTrip);
    }
}