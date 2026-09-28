package com.yatrayatri.repository;

import com.yatrayatri.entity.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {
    
    List<Trip> findByDestinationContainingIgnoreCase(String destination);
    
    List<Trip> findByDepartureLocationContainingIgnoreCase(String departureLocation);
    
    @Query("SELECT t FROM Trip t WHERE t.departureTime >= :startDate AND t.arrivalTime <= :endDate")
    List<Trip> findTripsBetweenDates(@Param("startDate") LocalDateTime startDate, 
                                     @Param("endDate") LocalDateTime endDate);
    
    @Query("SELECT t FROM Trip t WHERE t.availableSeats >= :minSeats AND t.status = 'SCHEDULED'")
    List<Trip> findAvailableTrips(@Param("minSeats") Integer minSeats);
}