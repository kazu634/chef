backend sensu {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_recv {
    if (req.http.host == "sensu.kazu634.com") {
        set req.backend = sensu;

        if (req.url ~ "(assets|font|img)") {
            return (lookup);
        }

        return (pass);
    }
}
