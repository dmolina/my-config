    awful.key({ altkey }, "Up",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "Down",
        function ()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),
