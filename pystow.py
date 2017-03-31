#!/usr/bin/python3
import sys
import os
import os.path
import argparse


def main():
    '''Main entry point.'''
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    parser.add_argument('package')
    parser.add_argument('-d', '--dir',
                        help='Create symlinks for the given directory')
    group.add_argument('-t', '--target',
                       help='Target directory')
    group.add_argument('-D', '--delete', action='store_true',
                       help='Remove the symlinks for the given directory')

    args = parser.parse_args()

    if args.dir and args.target:
        create_link(args.dir, args.target)
    elif args.target:
        create_link(args.package, args.target)
    elif args.delete:
        remove_link(args.package)
    elif args.dir:
        create_link(args.dir)
    else:
        create_link(args.package)


def create_link(src, dst=None):
    '''Creating the symlinks to destination.'''
    path = os.path.abspath(src)

    check_directory(path)
    if dst is None:
        current_dir = os.path.split(path)[0]
        sub_dir = os.path.split(current_dir)[0]
        dst = sub_dir

    content = [x for x in os.listdir(path)]
    check_dst_directory(dst, content)
    for name in content:
        os.symlink(os.path.join(path, name),
                   os.path.join(dst, name))


def remove_link(directory):
    '''Remove the symlink for the given directory.'''
    path = os.path.abspath(directory)

    check_directory(path)
    current_dir = os.path.split(path)[0]
    sub_dir = os.path.split(current_dir)[0]
    dst = sub_dir

    if check_rm_directory(path, dst):
        content = [x for x in os.listdir(path)]
        if os.path.exists(dst):
            for name in content:
                os.unlink(os.path.join(dst, name))
    else:
        print('There are no symlinks for the given directory')
        sys.exit(1)


def check_rm_directory(path, dst):
    '''Check if there are some symlinks for the given path in destination.'''
    content = os.listdir(path)
    amount = len(content)
    # given directory is empty
    if not content:
        print('There are no files in the given directory')
        sys.exit(1)

    check_amount = 0
    for name in content:
        if os.path.islink(os.path.join(dst, name)):
            check_amount += 1
        else:
            return False
    # check if all files from the given directory are symlinked,
    # otherwhise it's a manual created symlink OR corrupt
    if check_amount == amount:
        return True


def check_dst_directory(dst, content):
    '''Check if the destination directory contains matching files.'''
    if not os.path.exists(dst):
        print('Destination directory does not exists')
        sys.exit(1)

    result = []
    for name in content:
        if os.path.exists(os.path.join(dst, name)):
            result.append(name)

    if result:
        for name in result:
            print('Unable to create symlink: \'{}\' already exists'.format(name))

        sys.exit(1)


def check_directory(path):
    '''Checks the given path.'''
    if not os.path.exists(path):
        print('Directory does not exists')
        sys.exit(1)
    elif os.path.isfile(path):
        print('I do not create symlinks for a file')
        sys.exit(1)


if __name__ == '__main__':
    sys.exit(main())
