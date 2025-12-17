package com.recrutement.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "applications")
public class Application {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDateTime applicationDate;

    @Enumerated(EnumType.STRING)
    private ApplicationStatus status;

    // Link to the Candidate who is applying
    @ManyToOne
    @JoinColumn(name = "candidate_id", nullable = false)
    private Candidate candidate;

    // Link to the Job they are applying for
    @ManyToOne
    @JoinColumn(name = "job_offer_id", nullable = false)
    private JobOffer jobOffer;

    // Champ pour l'anonymat : l'admin doit valider pour révéler l'identité
    @Column(name = "admin_validated", nullable = false)
    private boolean adminValidated = false;

    // Lettre de motivation
    @Column(columnDefinition = "TEXT")
    private String coverLetter;

    public Application() {
        this.applicationDate = LocalDateTime.now();
        this.status = ApplicationStatus.PENDING;
    }

    public Application(Candidate candidate, JobOffer jobOffer) {
        this.candidate = candidate;
        this.jobOffer = jobOffer;
        this.applicationDate = LocalDateTime.now();
        this.status = ApplicationStatus.PENDING;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(LocalDateTime applicationDate) {
        this.applicationDate = applicationDate;
    }

    public ApplicationStatus getStatus() {
        return status;
    }

    public void setStatus(ApplicationStatus status) {
        this.status = status;
    }

    public Candidate getCandidate() {
        return candidate;
    }

    public void setCandidate(Candidate candidate) {
        this.candidate = candidate;
    }

    public JobOffer getJobOffer() {
        return jobOffer;
    }

    public void setJobOffer(JobOffer jobOffer) {
        this.jobOffer = jobOffer;
    }

    public boolean isAdminValidated() {
        return adminValidated;
    }

    public void setAdminValidated(boolean adminValidated) {
        this.adminValidated = adminValidated;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }
}