# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Simulates species tree using constant rate birth-death process
#'
#' @details Forward simulates to a number of tips. This function does so using
#'     the general algorithm of Hartmann et al. 2010.
#' @param sbr_ species birth rate (i.e. speciation rate)
#' @param sdr_ species death rate (i.e. extinction rate)
#' @param numbsim_ number of species trees to simulate
#' @param n_tips_ number of tips to simulate to
#' @return List of objects of the tree class (as implemented in APE)
#' @references
#' K. Hartmann, D. Wong, T. Stadler. Sampling trees from evolutionary models.
#'     Syst. Biol., 59(4): 465-476, 2010.
#'
#' T. Stadler. Simulating trees on a fixed number of extant species.
#'     Syst. Biol., 60: 676-684, 2011.
#' @examples
#' mu <- 0.5 # death rate
#' lambda <- 2.0 # birth rate
#' numb_replicates <- 10
#' numb_extant_tips <- 4
#' # simulate trees under the GSA so first simulates a tree with
#' # numb_extant_tips * 100 tips counting each time we have a tree with 10 tips
#' # then randomly picks one of those trees
#'
#' sim_sptree_bdp(sbr_ = lambda,
#'                 sdr_ = mu,
#'                 numbsim_ = numb_replicates,
#'                 n_tips_ = numb_extant_tips)
sim_sptree_bdp <- function(sbr_, sdr_, numbsim_, n_tips_) {
    .Call(`_treeducken_sim_sptree_bdp`, sbr_, sdr_, numbsim_, n_tips_)
}

#' Simulates species tree using constant rate birth-death process to a time
#'
#' @details Forward simulates a tree until a provided time is reached.
#' @param sbr_ species birth rate (i.e. speciation rate)
#' @param sdr_ species death rate (i.e. extinction rate)
#' @param numbsim_ number of species trees to simulate
#' @param t_ time to simulate to
#' @return List of objects of the tree class (as implemented in APE)
#' @references
#' K. Hartmann, D. Wong, T. Stadler. Sampling trees from evolutionary models.
#'     Syst. Biol., 59(4): 465-476, 2010.
#'
#' T. Stadler. Simulating trees on a fixed number of extant species.
#'     Syst. Biol., 60: 676-684, 2011.
#' @examples
#' mu <- 0.5 # death rate
#' lambda <- 2.0 # birth rate
#' numb_replicates <- 10
#' time <- 4
#'
#' sim_sptree_bdp(sbr_ = lambda,
#'                 sdr_ = mu,
#'                 numbsim_ = numb_replicates,
#'                 t_ = time)
sim_sptree_bdp_time <- function(sbr_, sdr_, numbsim_, t_) {
    .Call(`_treeducken_sim_sptree_bdp_time`, sbr_, sdr_, numbsim_, t_)
}

#' Simulates locus tree using constant rate birth-death-transfer process
#'
#' @details Given a species tree simulates a locus or gene family tree along
#'     the species tree.
#' @param species_tree species tree to simulate along
#' @param gbr gene birth rate
#' @param gdr gene death rate
#' @param lgtr gene trasnfer rate
#' @param num_loci number of locus trees to simulate
#' @return List of objects of the tree class (as implemented in APE)
#' @references
#' Rasmussen MD, Kellis M. Unified modeling of gene duplication, loss, and
#'     coalescence using a locus tree. Genome Res. 2012;22(4):755–765.
#'     doi:10.1101/gr.123901.111
#' @examples
#' # first simulate a species tree
#' mu <- 0.5 # death rate
#' lambda <- 2.0 # birth rate
#' numb_replicates <- 10
#' numb_extant_tips <- 4
#' # simulate trees under the GSA so first simulates a tree with
#' # numb_extant_tips * 100 tips counting each time we have a tree with 10 tips
#' # then randomly picks one of those trees
#'
#' sp_tree <- sim_sptree_bdp(sbr_ = lambda,
#'                 sdr = mu,
#'                 numbsim = numb_replicates,
#'                 n_tips = numb_extant_tips)
#'
#' gene_br <- 1.0
#' gene_dr <- 0.2
#' transfer_rate <- 0.2
#' sim_locustree_bdp(species_tree = sp_tree,
#'                   gbr = gene_br,
#'                   gdr = gene_dr,
#'                   lgtr = transfer_rate,
#'                   num_loci = 10)
sim_locustree_bdp <- function(species_tree, gbr, gdr, lgtr, num_loci) {
    .Call(`_treeducken_sim_locustree_bdp`, species_tree, gbr, gdr, lgtr, num_loci)
}

#' Simulates a cophylogenetic system using a paired birth-death process
#'
#' @details Simulates a cophylogenetic system using birth-death processes. The
#'     host tree is simulated following a constant rate birth-death process
#'     with an additional parameter - the cospeciation rate. This rate works as
#'     the speciation rate with the additional effect that if cospeciation
#'     occurs the symbiont tree also speciates. The symbiont tree is related to
#'     the host tree via an association matrix that describes which lineages
#'     are associated with which. The symbiont tree has an independent
#'     birth-death process with the addition of a host shift speciation rate
#'     that allows for the addition of more associated hosts upon symbiont
#'     speciation.
#' @param hbr_ host tree birth rate
#' @param hdr_ host tree death rate
#' @param sbr_ symbiont tree birth rate
#' @param sdr_ symbiont tree death rate
#' @param host_exp_rate_ host shift speciation rate
#' @param cosp_rate_ cospeciation rate
#' @param timeToSimTo_ time units to simulate until
#' @param numbsim_ number of replicates
#' @return A list containing the `host_tree`, the `symbiont_tree`, the
#'     association matrix at present, and the history of events that have
#'     occurred.
#' @examples
#'
#' host_mu <- 0.5 # death rate
#' host_lambda <- 2.0 # birth rate
#' numb_replicates <- 10
#' time <- 2.9
#' symb_mu <- 0.2
#' symb_lambda <- 0.4
#' host_shift_rate <- 0.1
#' cosp_rate <- 2.0
#'
#' cophylo_pair <- sim_cophylo_bdp(hbr_ = host_lambda,
#'                            hdr_ = host_mu,
#'                            cosp_rate_ = cosp_rate,
#'                            host_exp_rate_ = host_shift_rate,
#'                            sdr_ = symb_mu,
#'                            sbr_ = symb_lambda,
#'                            numbsim_ = numb_replicates,
#'                            timeToSimTo_ = time)
#'
sim_cophylo_bdp <- function(hbr_, hdr_, sbr_, sdr_, host_exp_rate_, cosp_rate_, timeToSimTo_, numbsim_) {
    .Call(`_treeducken_sim_cophylo_bdp`, hbr_, hdr_, sbr_, sdr_, host_exp_rate_, cosp_rate_, timeToSimTo_, numbsim_)
}

#' Simulate locus tree within species tree and gene trees within locus tree
#'
#' @description First simulates a locus tree within the confines of the input species tree using a constant-rate birth-death process
#' based on values of `gbr`, `gdr` and `lgtr`. Then simulates gene trees within that locus tree using the multi-locus coalescent process.
#' @param species_tree input species tree of class "phylo"
#' @param gbr gene birth rate
#' @param gdr gene death rate
#' @param lgtr lateral gene transfer rate'
#' @param theta the population genetic parameter
#' @param num_sampled_individuals number of individuals sampled within each locus lineage
#' @param num_loci number of loci to simulate
#' @param num_genes_per_locus number of genes to simulate within each locus
#'
#' @return A list of lists of length 2. The first element of each list of length 2 is `locus.tree` the locus tree and the second element is a list of the gene trees simulated within that locus tree. All trees are of class "phylo".
#'
#' @seealso sim_locustree_bdp
#'
#' @examples
#' # first simulate a species tree
#' mu <- 0.5
#' lambda <- 1.0
#' nt <- 6
#' tr <- sim_sptree_bdp(sbr = lambda, sdr = mu, numbsim = 1, n_tips = nt)
#' # for a locus tree with 100 genes sampled per locus tree
#' loctr_gentr <- sim_locustree_genetree_mlc(tr[[1]],
#'                                            gbr = 0.1,
#'                                            gdr = 0.0,
#'                                            lgtr = 0.0,
#'                                            theta = 1,
#'                                            num_sampled_individuals = 1,
#'                                            num_loci = 4,
#'                                            num_genes_per_locus = 100)
#'
#' @references
#' Mallo D, de Oliveira Martins L, Posada D (2015) SimPhy: Phylogenomic Simulation of Gene, Locus and Species Trees. Syst. Biol. doi: http://dx.doi.org/10.1093/sysbio/syv082
#'
sim_locustree_genetree_mlc <- function(species_tree, gbr, gdr, lgtr, num_loci, num_sampled_individuals, theta, num_genes_per_locus) {
    .Call(`_treeducken_sim_locustree_genetree_mlc`, species_tree, gbr, gdr, lgtr, num_loci, num_sampled_individuals, theta, num_genes_per_locus)
}

