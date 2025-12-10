import { memo } from "react"

type SvgProps = React.ComponentPropsWithoutRef<"svg">

export const HeadingThreeIcon = memo(({ className, ...props }: SvgProps) => {
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
        d="
          M18 7
          C17 5 15 4 12 4
          C8 4 5 7 5 12
          C5 17 8 20 12 20
          C15 20 17 19 18 17
          L16.5 16
          C15.7 17.3 14.2 18 12.2 18
          C9.2 18 7 15.7 7 12
          C7 8.3 9.2 6 12.2 6
          C14.2 6 15.7 6.7 16.5 8
          L18 7Z
        "
        fill="currentColor"
      />
    </svg>
  )
})

HeadingThreeIcon.displayName = "HeadingThreeIcon"
