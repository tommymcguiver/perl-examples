use String::Format;

my %fruit = (
    'a' => "apples",
    'b' => "bannanas",
    'g' => "grapefruits",
    'm' => "melons",
    'w' => "watermelons",
);

my $format = "I \x{22} like %a, %b, and %g, but not %m or %w.";


print stringf($format, %fruit);
