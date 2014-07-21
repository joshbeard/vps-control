Facter.add(:loadavg) do
  setcode do
    Facter::Util::Resolution.exec("/usr/bin/uptime | /usr/bin/awk -F \": \" '{print $2}'")
  end
end
