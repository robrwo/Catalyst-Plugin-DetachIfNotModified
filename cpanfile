# This file is generated by Dist::Zilla::Plugin::CPANFile v6.030
# Do not edit this file directly. To change prereqs, edit the `dist.ini` file.

requires "Catalyst" => "5.90018";
requires "HTTP::Headers" => "5.18";
requires "HTTP::Status" => "0";
requires "List::Util" => "0";
requires "Moose::Role" => "0";
requires "Ref::Util" => "0";
requires "namespace::autoclean" => "0";
requires "perl" => "v5.14.0";
recommends "Plack::Middleware::ConditionalGET" => "0";
recommends "Ref::Util::XS" => "0";

on 'test' => sub {
  requires "Catalyst" => "5.90018";
  requires "Catalyst::Controller" => "0";
  requires "Catalyst::Test" => "0";
  requires "File::Spec" => "0";
  requires "HTTP::Date" => "0";
  requires "HTTP::Request::Common" => "0";
  requires "Module::Metadata" => "0";
  requires "Moose" => "0";
  requires "Term::Size::Any" => "0";
  requires "Test::Log::Dispatch" => "0";
  requires "Test::More" => "0";
  requires "Test::Most" => "0";
  requires "Time::Seconds" => "0";
  requires "lib" => "0";
  requires "strict" => "0";
  requires "warnings" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::CleanNamespaces" => "0.15";
  requires "Test::EOF" => "0";
  requires "Test::EOL" => "0";
  requires "Test::Kwalitee" => "1.21";
  requires "Test::MinimumVersion" => "0";
  requires "Test::More" => "0.88";
  requires "Test::NoTabs" => "0";
  requires "Test::Perl::Critic" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Pod::LinkCheck" => "0";
  requires "Test::Portability::Files" => "0";
  requires "Test::TrailingSpace" => "0.0203";
};
