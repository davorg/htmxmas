package HTMXmas;
use Dancer2;
use Data::Printer;

use HTMXmas::Schema;

our $VERSION = '0.1';

get '/' => sub {
  my $sch = HTMXmas::Schema->get_schema;

  return template 'index.tt', {
    cols => [ 'name' ],
    rows => [ $sch->resultset('Child')->all ],
  };
};

post '/add' => sub {
  my $object = get_valid_columns(request);

  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  for (keys %$object) {
    delete $object->{$_} unless $object->{$_};
  }

  $rs->create($object);

  return template 'list_body.tt', {
    rows => [ $rs->all ],
  };
};

=pod

get '/list' => sub {
  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  return template 'list_body.tt', {
    rows => [ $rs->all ],
  };
};

get '/cancel' => sub {
  return template 'form.tt', {
    cols => \@columns,
  };
};

=cut

get '/reset/:id' => sub {
  my $id     = route_parameters->get('id');

  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  my $row = $rs->find($id);

  return sprintf '<td id="edit-%s">%s</td>', $row->id, $row->name;
};

get '/show/:id' => sub {
  my $id = route_parameters->get('id');

  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  my $row = $rs->find($id);
  
  return $row->vorname . ' ' . $row->nachname if $row;
  return 404;
};

get '/edit/:id' => sub {
  my $id = route_parameters->get('id');

  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  my $row = $rs->find($id);

  return template 'edit_name.tt', {
    row => $row,
  };
};

post '/update/:id' => sub {
  my $id = route_parameters->get('id');
  my $object = get_valid_columns(request);

use Data::Printer;
warn "VALID COLS: ", np($object), "\n";

  my $key = 'id';

  for (keys %$object) {
    delete $object->{$_} unless $object->{$_};
  }

warn "AFTER CLEANUP: ", np($object), "\n";

  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  if ($id) {
    my $row = $rs->find($id);
    $row->update($object);
    $row->discard_changes;

    return sprintf '<td id="edit-%s">%s</td>', $row->id, $row->name;
  }

  return '404';
};

=pod

del '/delete/:id' => sub {
  my $id = route_parameters->get('id');

  return 404 unless $id;

  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  $rs->find($id)->delete;

  return template 'list_body.tt', {
    rows => [ $rs->all ],
  };
};

post '/search' => sub {
  my $object = get_valid_columns(request);

  my $search_obj;
  for (keys %search_cols) {
    $search_obj->{$_} = $object->{$_} if $object->{$_};
  }

  my $sch = HTMXmas::Schema->get_schema;
  my $rs  = $sch->resultset('Child');

  my $where = [];
  for (keys %$search_obj) {
    push @$where, { $_ => { like => '%' . $search_obj->{$_} . '%' } };
  }

  my %where;
  %where = ( -and => $where ) if @$where > 1;

  return template 'list_body.tt', {
    rows => [ $rs->search( \%where )->all ],
  };
};

=cut

true;

sub get_valid_columns {
  my ($request) = @_;

warn "BODY: ", $request->body, "\n";

  my $data = from_json($request->body);
  my %object;

  for (qw[name]) {
    $object{$_} = $data->{$_} if $data->{$_};
  }

warn "OBJECT: ", np(%object), "\n";

  return \%object;
}
