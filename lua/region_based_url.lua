if ngx.var.region == 'RO' and ngx.var.name ~= 'ro'
then
    return ngx.redirect("https://ro.interactive.serveo.net", ngx.HTTP_MOVED_TEMPORARILY)
end
-- ngx.exit(ngx.OK)