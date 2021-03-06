% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{sim_cophylo_bdp}
\alias{sim_cophylo_bdp}
\title{Simulates a cophylogenetic system using a paired birth-death process}
\usage{
sim_cophylo_bdp(
  hbr_,
  hdr_,
  sbr_,
  sdr_,
  host_exp_rate_,
  cosp_rate_,
  timeToSimTo_,
  numbsim_
)
}
\arguments{
\item{hbr_}{host tree birth rate}

\item{hdr_}{host tree death rate}

\item{sbr_}{symbiont tree birth rate}

\item{sdr_}{symbiont tree death rate}

\item{host_exp_rate_}{host shift speciation rate}

\item{cosp_rate_}{cospeciation rate}

\item{timeToSimTo_}{time units to simulate until}

\item{numbsim_}{number of replicates}
}
\value{
A list containing the `host_tree`, the `symbiont_tree`, the
    association matrix at present, and the history of events that have
    occurred.
}
\description{
Simulates a cophylogenetic system using a paired birth-death process
}
\details{
Simulates a cophylogenetic system using birth-death processes. The
    host tree is simulated following a constant rate birth-death process
    with an additional parameter - the cospeciation rate. This rate works as
    the speciation rate with the additional effect that if cospeciation
    occurs the symbiont tree also speciates. The symbiont tree is related to
    the host tree via an association matrix that describes which lineages
    are associated with which. The symbiont tree has an independent
    birth-death process with the addition of a host shift speciation rate
    that allows for the addition of more associated hosts upon symbiont
    speciation.
}
\examples{

host_mu <- 0.5 # death rate
host_lambda <- 2.0 # birth rate
numb_replicates <- 10
time <- 2.9
symb_mu <- 0.2
symb_lambda <- 0.4
host_shift_rate <- 0.1
cosp_rate <- 2.0

cophylo_pair <- sim_cophylo_bdp(hbr_ = host_lambda,
                           hdr_ = host_mu,
                           cosp_rate_ = cosp_rate,
                           host_exp_rate_ = host_shift_rate,
                           sdr_ = symb_mu,
                           sbr_ = symb_lambda,
                           numbsim_ = numb_replicates,
                           timeToSimTo_ = time)

}
