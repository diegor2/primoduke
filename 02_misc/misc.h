/*
 *   Definições das operações de manipulação de arquivos que serão
 * usadas para acessar o nó criado em /dev
 *
 *   Definitions for the file hander operations whose will be used
 * to access the node created inside /dev
 *
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/errno.h>
#include <linux/miscdevice.h>

#define DEVICE "fisl15m"
#define FISL_MESSAGE "Viva o software livre"
#define BUFF_LEN 128
#define SUCCESS 0

static ssize_t device_read(struct file *, char *, size_t, loff_t *);

static ssize_t device_write(struct file *, const char *, size_t, loff_t *);

static int device_open(struct inode *, struct file *);

static int device_release(struct inode *, struct file *);

