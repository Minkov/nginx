if ngx.var.region == 'RO' and ngx.var.name ~= 'ro'
then
    ngx.redirect("https://google.com")
end

ngx.exit(ngx.OK)