# Setup

## From the live environment

Get online. This will probably require android tethering?

    # ls /sys/firmware/efi/efivars

should return some stuff.

    # timedatectl set-ntp true

Check disks

    # fdisk -l

and partition the right one with (assumed `sda` below)

    # gdisk /dev/sdx
    o
    n
    default
    default
    +512M
    ef00
    n
    default
    default
    default
    default
    p
    w
    etc

Format the boot partition

    # mkfs.fat -F32 /dev/sda1

Encrypt the root partition

    # cryptsetup -y -v luksFormat /dev/sdaX
    # cryptsetup open /dev/sdaX cryptroot
    # mkfs.ext4 /dev/mapper/cryptroot
    # mount /dev/mapper/cryptroot /mnt

Mount the boot partition as well.

    # mkdir /mnt/boot
    # mount /dev/sda1 /mnt/boot

Pacstrap!

    # pacstrap /mnt base networkmanager intel-ucode grub efibootmgr

[Note: probably also going to have to install some wireless firmware. Not sure
when the best time to do this is though...]

Generate fstab file

    # genfstab -U /mnt >> /mnt/etc/fstab

I am chroot

    # arch-chroot /mnt
    # ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
    # hwclock --systohc

Uncomment `en_US.UTF-8 UTF-8` in `/etc/locale.gen`, then

    # locale-gen
    # echo "LANG=en_US.UTF-8" > /etc/locale.conf
    # echo "<SOME_HOSTNAME>" > /etc/hostname
    # systemctl enable NetworkManager.service

Change the `HOOKS` line in `/etc/mkinitcpio.conf` to read something like

    HOOKS="base udev autodetect modconf consolefont keyboard block encrypt filesystems fsck"

and run

    # mkinitcpio -p linux

set the root password

    # passwd

Install grub

    # grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub

Modify the `GRUB_CMDLINE_LINUX` line of `/etc/default/grub` to account for
`dm-crypt`. We'll append the required line to the file and then complete the
edit manually. Also set `intel_iomu=off`.

    # echo "GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=$(blkid -o value -s UUID /dev/sda2):cryptroot root=/dev/mapper/cryptroot\"" >> /etc/default/grub
    # vi /etc/default/grub

Should end up with something like this:

    GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=off"
    GRUB_CMDLINE_LINUX="cryptdevice=UUID=9a66d3de-8a24-4885-8a99-76bd3597b213:cryptroot root=/dev/mapper/cryptroot"

Then generate the config

    # grub-mkconfig -o /boot/grub/grub.cfg

Reboot.

## Post installation

    # pacman -S zsh sudo
    # useradd -m -G wheel -s /usr/bin/zsh callum
    # passwd callum

Give sudo access to members of `wheel`

    # visudo

and then log out and back in again as `callum`

Install all the things.

    $ pacman -S base-devel git htop neovim pass tree xorg xorg-xinit alsa-utils ripgrep dkms broadcom-wl-dkms

Clone dots

    $ git init
    $ git pull https://github.com/hot-leaf-juice/dots

Log out and log in again.

Bootstrap `cower`

    $ mkdir builds
    $ cd builds
    $ git clone https://aur.archlinux.org/cower.git
    $ cd cower
    $ makepkg -si

## Useful links
https://wiki.archlinux.org/index.php/installation_guide
https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system
https://wiki.archlinux.org/index.php/GRUB
https://wiki.archlinux.org/index.php/EFI_System_Partition
https://www.mankier.com/1/nmtui
