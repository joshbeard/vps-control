Facter.add(:numusers) do
  setcode do
    Facter::Util::Resolution.exec("/usr/bin/who | wc -l")
  end
end
