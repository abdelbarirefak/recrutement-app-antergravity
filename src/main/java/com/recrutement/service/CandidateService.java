package com.recrutement.service;

import com.recrutement.dao.CandidateDAO;
import com.recrutement.entity.Candidate;
import java.util.List;

public class CandidateService {

    private CandidateDAO candidateDAO = new CandidateDAO();

    public void createCandidateProfile(Candidate candidate) {
        // Business Logic: Ensure the user is actually linked
        if (candidate.getUser() == null) {
            throw new IllegalArgumentException("A candidate profile must be linked to a User account.");
        }
        candidateDAO.save(candidate);
    }

    public Candidate getCandidate(Long id) {
        return candidateDAO.findById(id);
    }

    public List<Candidate> getAllCandidates() {
        return candidateDAO.findAll();
    }
}