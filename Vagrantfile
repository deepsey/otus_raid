# Describe VMs
home = ENV['HOME']
MACHINES = {
  # VM name "kernel update"
  :"otus-raid" => {
              # VM box
              :box_name => "centos/7",
              # IP address
              :ip_addr => '192.168.100.33',     
              # VM CPU count
              :cpus => 2,
              # VM RAM size (Mb)
              :memory => 1024,
              # forwarded ports
              :forwarded_port => [],
              # add disks
              :disks => {
                :sata1 => {
                :dfile => home + '/VirtualBox VMs/sata1.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 1
                },
                :sata2 => {
                :dfile => home + '/VirtualBox VMs/sata2.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 2
                },         
                :sata3 => {
                :dfile => home + '/VirtualBox VMs/sata3.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 3
                },
                :sata4 => {
                :dfile => home + '/VirtualBox VMs/sata4.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 4
                },
                :sata5 => {
                :dfile => home + '/VirtualBox VMs/sata5.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 5
                },
                :sata6 => {
                :dfile => home + '/VirtualBox VMs/sata6.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 6
                },  
                :sata7 => {
                :dfile => home + '/VirtualBox VMs/sata7.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 7
                }, 
                :sata8 => {
                :dfile => home + '/VirtualBox VMs/sata8.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 8
                },  
                :sata9 => {
                :dfile => home + '/VirtualBox VMs/sata9.vdi', # Указываем где будут лежать файлы наших дисков
                :size => 250,
                :port => 9
                }            
                         
              }
   },                
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    # Disable shared folders
    config.vm.synced_folder ".", "/vagrant", disabled: true
    # Apply VM config
    config.vm.define boxname do |box|
      # Set VM base box and hostname
      box.vm.box = boxconfig[:box_name]
      box.vm.host_name = boxname.to_s
      box.vm.network "private_network", ip: boxconfig[:ip_addr]
      # Port-forward config if present
      if boxconfig.key?(:forwarded_port)
        boxconfig[:forwarded_port].each do |port|
          box.vm.network "forwarded_port", port
        end
      end
      # VM resources config
      
      box.vm.provider "virtualbox" do |v|
        # Set VM RAM size and CPU count
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
        v.name = boxname.to_s
        needsController = false
        boxconfig[:disks].each do |dname, dconf|
			  unless File.exist?(dconf[:dfile])
				v.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                                needsController =  true
              end
	    end
                  if needsController == true
                     v.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                     boxconfig[:disks].each do |dname, dconf|
                         v.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                     end
                  end
      end
    end
  end
end
