if ngx.var.region == 'RO' and ngx.var.name == 'ro'
then
    ngx.var.is_ok = 'yes'
elseif ngx.var.region == 'RO' and ngx.var.name ~= 'ro'
then
    ngx.var.is_ok = 'no'
else
    ngx.var.is_ok = 'yes'
end