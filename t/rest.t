use Test::More tests => 8;

{
	package RESTExample;

	use Moose;
	with 'Role::REST::Client';

	sub bar {
		my ($self) = @_;
		my $res = $self->post('foo/bar/baz', {foo => 'bar'});
		my $code = $res->code;
		my $data = $res->data;
		return $data if $code == 200;
   }

}

my %testdata = (
	server =>      'http://localhost:3000',
	type   =>      'application/json',
	clientattrs => {timeout => 5},
);
ok(my $obj = RESTExample->new(%testdata), 'New object');
isa_ok($obj, 'RESTExample');

for my $item (qw/post get put delete _call _headers/) {
    ok($obj->can($item), "Role method $item exists");
}
