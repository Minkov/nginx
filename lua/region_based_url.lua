if ngx.var.region == 'RO' and ngx.var.name ~= 'ro'
then
    return ngx.redirect("https://ro.interactive.serveo.net", ngx.HTTP_MOVED_TEMPORARILY)
elseif ngx.var.region == 'BG' and ngx.var.name == 'ro'
then
    return ngx.redirect("https://interactive.serveo.net", ngx.HTTP_MOVED_TEMPORARILY)
end
-- ngx.exit(ngx.OK)