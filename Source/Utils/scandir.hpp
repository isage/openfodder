#ifndef __SCANDIR_HPP__
#define __SCANDIR_HPP__
int
scandir(const char *dirname,
	struct dirent ***ret_namelist,
	int (*select)(const struct dirent *),
	int (*compar)(const struct dirent **, const struct dirent **));
#endif