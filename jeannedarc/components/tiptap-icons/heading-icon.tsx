import { memo } from "react"

type SvgProps = React.ComponentPropsWithoutRef<"svg">

export const HeadingIcon = memo(({ className, ...props }: SvgProps) => {
  return (
    <svg
      width="24"
      height="24"
      className={className}
      viewBox="0 0 24 24"
      fill="currentColor"
      xmlns="http://www.w3.org/2000/svg"
      {...props}
    >
      <path
        fillRule="evenodd"
        clipRule="evenodd"
        d="M6 2.5C5.17157 2.5 4.5 3.17157 4.5 4V20C4.5 20.8284 5.17157 21.5 6 21.5C6.82843 21.5 7.5 20.8284 7.5 20V13.5H14C15.4587 13.5 16.8576 12.9205 17.8891 11.8891C18.9205 10.8576 19.5 9.45869 19.5 8C19.5 6.54131 18.9205 5.14236 17.8891 4.11091C16.8576 3.07946 15.4587 2.5 14 2.5H6ZM7.5 10.5V5.5H14C14.663 5.5 15.2989 5.76339 15.7678 6.23223C16.2366 6.70107 16.5 7.33696 16.5 8C16.5 8.66304 16.2366 9.29893 15.7678 9.76777C15.2989 10.2366 14.663 10.5 14 10.5H7.5Z"
        fill="currentColor"
      />
    </svg>
  )
})

HeadingIcon.displayName = "HeadingIcon"
