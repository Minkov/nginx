if ngx.var.region == 'RO' and ngx.var.name ~= 'ro'
then
    ngx.redirect("https://ro.interactive.serveo.net")
end

-- ngx.exit(ngx.OK)