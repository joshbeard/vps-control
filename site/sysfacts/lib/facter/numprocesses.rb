Facter.add(:numprocesses) do
  setcode do
    ps_cmd = Facter.value(:ps)
    Facter::Util::Resolution.exec("#{ps_cmd}").lines.count
  end
end
