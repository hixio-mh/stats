#!/usr/bin/perl

sub num {
    my ($t)=@_;
    if($t =~ /^curl-(\d)_(\d+)_(\d+)/) {
        return 10000*$1 + 100*$2 + $3;
    }
    elsif($t =~ /^curl-(\d)_(\d+)/) {
        return 10000*$1 + 100*$2;
    }
}


sub sortthem {
    return num($a) <=> num($b);
}

@alltags= `git tag -l`;

foreach my $t (@alltags) {
    chomp $t;
    if($t =~ /^curl-([0-9_]*[0-9])\z/) {
        push @releases, $t;
    }
}

sub tag2date {
    my ($t)=@_;
    open(G, "git show $t --pretty=\"Date: %ci\" -s 2>/dev/null|");
    my $d;
    while(<G>) {
        if($_ =~ /^Date: (\d+-\d+-\d+) (\d+:\d+:\d+)/) {
            # strip off the time zone and time
            $d = "$1";
            last;
        }
    }
    close(G);
    return $d;
}

sub contribs {
    my ($tag) = @_;

    my @file = `git show $tag:RELEASE-NOTES 2>/dev/null`;
    foreach $f (@file) {
        if($f =~ /ontributors: *(\d+)/) {
            return $1;
        }
    }
    return 0;
}

# git show curl-7_8:docs/THANKS | grep -c ' - '
# 67

print <<EARLY
curl 7.8;2001-06-07;67
curl 7.9;2001-09-23;73
curl 7.10;2002-10-01;80
curl 7.11.0;2004-01-22;94
curl 7.12.0;2004-06-02;96
curl 7.13.0;2005-02-01;106
EARLY
    ;;

foreach my $t (sort sortthem @releases) {
    my $d = tag2date($t);
    my $c = contribs($t);
    if($c) {
        # prettyfy
        $t =~ s/_/./g;
        $t =~ s/-/ /g;
        print "$t;$d;$c\n";
    }
}
