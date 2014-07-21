Facter.add(:loads) do
  setcode do
    uptime = `/usr/bin/uptime`
    loadavg = uptime.split(': ')[1].strip
    loadavg
  end
end
