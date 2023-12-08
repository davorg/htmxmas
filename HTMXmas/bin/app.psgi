#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use HTMXmas;

HTMXmas->to_app;

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use HTMXmas;
use Plack::Builder;

builder {
    enable 'Deflater';
    HTMXmas->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use HTMXmas;
use HTMXmas_admin;

use Plack::Builder;

builder {
    mount '/'      => HTMXmas->to_app;
    mount '/admin'      => HTMXmas_admin->to_app;
}

=end comment

=cut

