package com.recrutement.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "job_offers")
public class JobOffer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String description;

    private String location; // e.g., "Paris", "Remote"

    private Double salary;

    @Enumerated(EnumType.STRING)
    private JobStatus status;

    private LocalDateTime postedDate;

    // RELATIONSHIP: Many JobOffers belong to One Enterprise
    @ManyToOne
    @JoinColumn(name = "enterprise_id", nullable = false)
    private Enterprise enterprise;

    // Compétences requises pour le matching (séparées par des virgules)
    @Column(name = "required_skills", columnDefinition = "TEXT")
    private String requiredSkills;

    // Constructors
    public JobOffer() {
        this.postedDate = LocalDateTime.now(); // Auto-set date
        this.status = JobStatus.OPEN; // Default status
    }

    public JobOffer(String title, String description, String location, Double salary, Enterprise enterprise) {
        this.title = title;
        this.description = description;
        this.location = location;
        this.salary = salary;
        this.enterprise = enterprise;
        this.postedDate = LocalDateTime.now();
        this.status = JobStatus.OPEN;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Double getSalary() {
        return salary;
    }

    public void setSalary(Double salary) {
        this.salary = salary;
    }

    public JobStatus getStatus() {
        return status;
    }

    public void setStatus(JobStatus status) {
        this.status = status;
    }

    public LocalDateTime getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(LocalDateTime postedDate) {
        this.postedDate = postedDate;
    }

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public String getRequiredSkills() {
        return requiredSkills;
    }

    public void setRequiredSkills(String requiredSkills) {
        this.requiredSkills = requiredSkills;
    }
}