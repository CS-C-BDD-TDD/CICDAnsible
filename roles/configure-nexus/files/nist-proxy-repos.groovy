if ( !repository.repositoryManager.exists( 'nist-cve-proxy' ) ){
    repository.createRawProxy( 'nist-cve-proxy', 'https://nvd.nist.gov/feeds/');
}