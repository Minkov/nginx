if ngx.var.region == 'RO' and ngx.var.name ~= 'ro'
then
    return ngx.redirect("https://ro.interactive.serveo.net" .. ngx.var.request_uri, ngx.HTTP_MOVED_TEMPORARILY)
elseif ngx.var.region ~= 'RO' and ngx.var.name == 'ro'
then
    return ngx.redirect("https://interactive.serveo.net" .. ngx.var.request_uri, ngx.HTTP_MOVED_TEMPORARILY)
end
-- ngx.exit(ngx.OK)
