package com.recrutement.entity;

import jakarta.persistence.*;

/**
 * Entretien planifié par l'admin.
 * Lie une candidature acceptée à un créneau disponible avec un lien Google
 * Meet.
 */
@Entity
@Table(name = "interviews")
public class Interview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "meet_link")
    private String meetLink;

    @OneToOne
    @JoinColumn(name = "application_id", nullable = false)
    private Application application;

    @OneToOne
    @JoinColumn(name = "slot_id", nullable = false)
    private InterviewSlot slot;

    public Interview() {
    }

    public Interview(Application application, InterviewSlot slot, String meetLink) {
        this.application = application;
        this.slot = slot;
        this.meetLink = meetLink;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMeetLink() {
        return meetLink;
    }

    public void setMeetLink(String meetLink) {
        this.meetLink = meetLink;
    }

    public Application getApplication() {
        return application;
    }

    public void setApplication(Application application) {
        this.application = application;
    }

    public InterviewSlot getSlot() {
        return slot;
    }

    public void setSlot(InterviewSlot slot) {
        this.slot = slot;
    }
}
