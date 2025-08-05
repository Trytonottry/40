#include <linux/module.h>
#include <linux/usb.h>
#include <linux/slab.h>
#include <crypto/public_key.h>

static const char *allowed_serials[] = {
    /* рассчитывается на этапе install.sh */
};

static int usb_warden_probe(struct usb_interface *intf,
                            const struct usb_device_id *id)
{
    struct usb_device *udev = interface_to_usbdev(intf);
    char *serial = udev->serial ? udev->serial : "";
    bool ok = false;

    for (int i = 0; i < ARRAY_SIZE(allowed_serials); i++) {
        if (crypto_memneq(serial, allowed_serials[i], strlen(serial)) == 0) {
            ok = true;
            break;
        }
    }
    if (!ok) {
        dev_info(&udev->dev, "USB-Warden: blocked (serial %s)\n", serial);
        return -ENODEV;
    }
    return 0;
}

static struct usb_device_id usb_warden_table[] = {
    { USB_DEVICE_INFO(USB_CLASS_MASS_STORAGE, 0, 0) },
    {}
};
MODULE_DEVICE_TABLE(usb, usb_warden_table);

static struct usb_driver usb_warden_driver = {
    .name  = "usb_warden",
    .id_table = usb_warden_table,
    .probe = usb_warden_probe,
};
module_usb_driver(usb_warden_driver);
MODULE_LICENSE("GPL");