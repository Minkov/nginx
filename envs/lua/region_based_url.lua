if ngx.var.region == 'RO' and ngx.var.name ~= 'ro'
then
    return ngx.redirect("https://ro.softuniorg.cf" .. ngx.var.request_uri, ngx.HTTP_MOVED_TEMPORARILY)
elseif ngx.var.region ~= 'RO' and ngx.var.name == 'ro'
then
    return ngx.redirect("https://softuniorg.cf" .. ngx.var.request_uri, ngx.HTTP_MOVED_TEMPORARILY)
end
-- ngx.exit(ngx.OK)
