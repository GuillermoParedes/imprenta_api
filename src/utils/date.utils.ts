const getStartDate = (date) => {
    const newDate = new Date(date)
    newDate.setUTCHours(0,0,0,0)
    return newDate
}
const getEndDate = (date) => {
    const newDate = new Date(date)
    newDate.setUTCHours(0,0,0,0)
    return newDate
}
export { getStartDate, getEndDate }