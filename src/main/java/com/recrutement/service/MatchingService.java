package com.recrutement.service;

import com.recrutement.entity.Candidate;
import com.recrutement.entity.JobOffer;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * Service de matching entre candidats et offres d'emploi.
 * Calcule un score de compatibilité de 0 à 100%.
 * 
 * Algorithme :
 * - 70% basé sur les compétences (skills du candidat vs requiredSkills de
 * l'offre)
 * - 30% basé sur la correspondance des titres de poste
 */
public class MatchingService {

    private static final double SKILLS_WEIGHT = 0.70;
    private static final double TITLE_WEIGHT = 0.30;

    /**
     * Calcule le score de compatibilité entre un candidat et une offre.
     * 
     * @param candidate Le candidat
     * @param offer     L'offre d'emploi
     * @return Score de 0 à 100
     */
    public int calculateMatchScore(Candidate candidate, JobOffer offer) {
        double skillsScore = calculateSkillsScore(candidate.getSkills(), offer.getRequiredSkills());
        double titleScore = calculateTitleScore(candidate.getTitle(), offer.getTitle());

        double totalScore = (skillsScore * SKILLS_WEIGHT) + (titleScore * TITLE_WEIGHT);
        return (int) Math.round(totalScore);
    }

    /**
     * Calcule le score basé sur les compétences.
     * Compare les mots-clés séparés par des virgules.
     */
    private double calculateSkillsScore(String candidateSkills, String requiredSkills) {
        if (candidateSkills == null || candidateSkills.isEmpty()
                || requiredSkills == null || requiredSkills.isEmpty()) {
            return 0.0;
        }

        Set<String> candidateSet = normalizeSkills(candidateSkills);
        Set<String> requiredSet = normalizeSkills(requiredSkills);

        if (requiredSet.isEmpty()) {
            return 100.0; // Pas d'exigences = 100%
        }

        // Compter les compétences correspondantes
        long matchCount = candidateSet.stream()
                .filter(skill -> requiredSet.stream().anyMatch(req -> req.contains(skill) || skill.contains(req)))
                .count();

        return (matchCount * 100.0) / requiredSet.size();
    }

    /**
     * Calcule le score basé sur les titres de poste.
     * Utilise une correspondance partielle des mots.
     */
    private double calculateTitleScore(String candidateTitle, String offerTitle) {
        if (candidateTitle == null || candidateTitle.isEmpty()
                || offerTitle == null || offerTitle.isEmpty()) {
            return 0.0;
        }

        Set<String> candidateWords = normalizeSkills(candidateTitle);
        Set<String> offerWords = normalizeSkills(offerTitle);

        if (offerWords.isEmpty()) {
            return 100.0;
        }

        long matchCount = candidateWords.stream()
                .filter(word -> offerWords.stream().anyMatch(ow -> ow.contains(word) || word.contains(ow)))
                .count();

        double score = (matchCount * 100.0) / Math.max(candidateWords.size(), offerWords.size());
        return Math.min(score, 100.0);
    }

    /**
     * Normalise une chaîne de compétences en un Set de mots-clés en minuscules.
     */
    private Set<String> normalizeSkills(String skills) {
        if (skills == null)
            return new HashSet<>();

        return new HashSet<>(Arrays.asList(
                skills.toLowerCase()
                        .replaceAll("[^a-zA-Z0-9àâäéèêëïîôùûüç,\\s]", "")
                        .split("[,\\s]+")));
    }

    /**
     * Retourne le badge correspondant au score.
     */
    public String getMatchBadge(int score) {
        if (score >= 80) {
            return "EXCELLENT";
        } else if (score >= 50) {
            return "BON";
        } else if (score >= 25) {
            return "MOYEN";
        } else {
            return "FAIBLE";
        }
    }

    /**
     * Retourne la classe CSS pour le badge.
     */
    public String getBadgeClass(int score) {
        if (score >= 80) {
            return "bg-emerald-500 text-white";
        } else if (score >= 50) {
            return "bg-blue-500 text-white";
        } else if (score >= 25) {
            return "bg-yellow-500 text-white";
        } else {
            return "bg-gray-400 text-white";
        }
    }
}
