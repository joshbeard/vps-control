Facter.add(:loads_1) do
  setcode do
    Facter.value(:loads).split(' ')[0]
  end
end
