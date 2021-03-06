#ifndef Simulator_h
#define Simulator_h
#include "GeneTree.h"
#include "SymbiontTree.h"
#include <set>
#include <map>
#include <RcppArmadillo.h>

class Simulator
{
    protected:
        double      currentSimTime;
        unsigned    simType;
        unsigned    numTaxaToSim, gsaStop;
        unsigned    numLoci;
        unsigned    numGenes;
        double      speciationRate, extinctionRate;
        double      samplingRate;
        double      treeScale;
        double      geneBirthRate, geneDeathRate, transferRate;
        double      propTransfer, propDuplicate;
        unsigned    indPerPop;
        double      popSize;
        double      generationTime;
        bool        printSOUT;
        std::vector<SpeciesTree*>   gsaTrees;
        SpeciesTree*    spTree;
        LocusTree*      lociTree;
        std::vector<LocusTree*> locusTrees;
        GeneTree*       geneTree;
        std::vector<GeneTree*> geneTrees;
        // symbiont tree varibles
        SymbiontTree*   symbiontTree;
        double      cospeciationRate;
        double      timeToSim;
        int         hostLimit;
        arma::umat   assocMat;

        Rcpp::IntegerVector inOrderVecOfHostIndx;
        Rcpp::IntegerVector inOrderVecOfSymbIndx;
        Rcpp::CharacterVector inOrderVecOfEvent;
        Rcpp::NumericVector inOrderVecOfEventTimes;

    public:
        // Simulating species tree only
        Simulator(unsigned numTaxaToSim,
                  double speciationRate,
                  double extinctionRate,
                  double rho);
        // Simulating species and locus tree
        Simulator(unsigned numTaxaToSim,
                  double speciationRate,
                  double extinctionRate,
                  double rho,
                  unsigned numLociToSim,
                  double geneBirthRate,
                  double geneDeathRate,
                  double transferRate);
        // Simulating species and locus tree with proportion of transfer (e.g. hybridization, linkage)
        // // CAN THIS BE DELETED??
        //.
        Simulator(unsigned numTaxaToSim,
                  double speciationRate,
                double extinctionRate,
                double rho,
                unsigned numLociToSim,
                double geneBirthRate,
                double geneDeathRate,
                double transferRate,
                double propTransfer);
        // Simulating species and locus trees with one gene tree per locus tree
        Simulator(unsigned numTaxaToSim,
                double speciationRate,
                double extinctionRate,
                double rho,
                unsigned numLociToSim,
                double geneBirthRate,
                double geneDeathRate,
                double transferRate,
                unsigned indPerPop,
                double popSize,
                double genTime,
                int ng,
                double og,
                double ts,
                bool sout);
        //
        Simulator(double timeToSimTo,
                  double hostSpeciationRate,
                  double hostExtinctionRate,
                  double symbSpeciationRate,
                  double symbExtinctionRate,
                  double switchingRate,
                  double cospeciationRate,
                  double rho,
                  int hostLimit);
        ~Simulator();

        void    setSpeciesTree(SpeciesTree *st) { spTree = st; }
        bool    gsaBDSim();
        bool    bdsaBDSim();
        bool    bdSimpleSim();
        bool    pairedBDPSim();
        bool    coalescentSim();
        bool    simSpeciesTree();
        bool    simSpeciesTreeTime();
        bool    simLocusTree();
        bool    simGeneTree(int j);
        bool    simHostSymbSpeciesTreePair();
        bool    gsaCheckStop();
        void    initializeSim();
        void    processGSASim();
        void    prepGSATreeForReconstruction();
        void    processSpTreeSim();
        double  calcSpeciesTreeDepth();
        double  calcExtantSpeciesTreeDepth();
        double  calcLocusTreeDepth(int i);
        int     findNumberTransfers();
        std::set<double, std::greater<double> > getEpochs();
        //SpeciesTree*    getSpeciesTree() {SpeciesTree* spec_tree = new SpeciesTree(*spTree); return spec_tree;}
        SpeciesTree*    getSpeciesTree() { return spTree; }
        LocusTree*      getLocusTree() {return lociTree;}
        SymbiontTree*   getSymbiontTree() {return symbiontTree;}
        GeneTree*       getGeneTree() {return geneTree; }
        double          getTimeToSim() {return timeToSim; }
        void            setTimeToSim(double tts) {timeToSim = tts; }

        NumericMatrix   getSymbiontEdges() { return symbiontTree->getEdges(); }
        NumericMatrix   getSpeciesEdges() { return spTree->getEdges(); }
        NumericMatrix   getLocusEdges() { return lociTree->getEdges(); }
        NumericMatrix   getGeneEdges(int j) { return geneTrees[j]->getGeneEdges(); }

        std::vector<double>    getSymbiontEdgeLengths() { return symbiontTree->getEdgeLengths(); }
        std::vector<double>    getSpeciesEdgeLengths() { return spTree->getEdgeLengths(); }
        std::vector<double>    getLocusEdgeLengths() { return lociTree->getEdgeLengths(); }
        std::vector<double>    getGeneEdgeLengths(int j) { return geneTrees[j]->getEdgeLengths(); }

        int    getSymbiontNnodes() { return symbiontTree->getNnodes(); }
        int    getSpeciesNnodes() { return spTree->getNnodes(); }
        int    getLocusNnodes() { return lociTree->getNnodes(); }
        int    getGeneNnodes(int j) { return geneTrees[j]->getNnodes(); }

        std::vector<std::string> getSpeciesTipNames() { return spTree->getTipNames(); }
        std::vector<std::string> getSymbiontTipNames() { return symbiontTree->getTipNames(); }
        std::vector<std::string> getLocusTipNames() { return lociTree->getTipNames(); }
        std::vector<std::string> getGeneTipNames(int j) { return geneTrees[j]->getTipNames(); }

        double    getSpeciesTreeRootEdge();
        double    getLocusTreeRootEdge();
        double    getSymbiontTreeRootEdge();
        double    getGeneTreeRootEdge(int j);

        arma::umat    getAssociationMatrix() { return assocMat; }
        arma::umat    cophyloEvent(double eventTime, arma::umat assocMat);
        arma::umat    cophyloERMEvent(double eventTime, arma::umat assocMat);
        arma::umat    cospeciationEvent(double eventTime, arma::umat assocMat);
        arma::umat    symbiontTreeEvent(double eventTime, arma::umat assocMat);
        Rcpp::DataFrame createEventDF();
        void      updateEventIndices();
        void      updateEventVector(int h, int s, int e, double time);
        void    clearEventDFVecs();
        void    initializeEventVector();
};

extern Rcpp::List bdsim_species_tree(double sbr,
                                     double sdr,
                                     int numbsim,
                                     int n_tips);

extern Rcpp::List sim_bdsimple_species_tree(double sbr,
                                            double sdr,
                                            int numbsim,
                                            double timeToSimTo);

extern Rcpp::List sim_locus_tree(SpeciesTree* species_tree,
                                 double gbr,
                                 double gdr,
                                 double lgtr,
                                 int numLoci);

extern Rcpp::List sim_host_symb_treepair(double hostbr,
                                         double hostdr,
                                         double symbbr,
                                         double symbdr,
                                         double switchrate,
                                         double cosprate,
                                         double timeToSimTo,
                                         int numbsim);

extern Rcpp::List sim_locus_tree_gene_tree(SpeciesTree* species_tree,
                                           double gbr,
                                           double gdr,
                                           double lgtr,
                                           int numLoci,
                                           double popsize,
                                           int samples_per_lineage,
                                           int numGenesPerLocus);

extern Rcpp::List sim_genetree_msc(SpeciesTree* species_tree,
                                   double popsize,
                                   int samples_per_lineage,
                                   int numbsim);

#endif /* Simulator_h */
